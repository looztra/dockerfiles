#! /bin/bash

# Charger la configuration par défaut si elle existe
[ -e /etc/master-backup.conf ] && . /etc/master-backup.conf

# Charger une configuration si fournie en argument du script pouvant écraser certaines
# valeurs de la configuration par défaut
# Seules les configurations dont le template est /etc/master-backup*.conf sont acceptées
if [ -n "$1" -a -z "${1##/etc/master-backup*}" -a -z "${1%%*.conf}" -a -e "$1" ]; then
	. $1
	shift
elif [ "$1" == "--conf" ]; then
	[ -n "$2" -a -e "$2" ] && . $2
	shift ; shift
fi

export PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin

: ${BASE:=/var/backups/master}
: ${DEV:=}
: ${TAG:=Master-Backup}
: ${URL:=}
: ${WHAT:=}
: ${OPTIONS:=}
: ${PASSPHRASE:=__duplicity__GnuPG__passphrase__}
: ${CACHE:=~/.cache/duplicity}

timestamp () {
	date +%F-%Hh%M
}

log () {
	logger -st $TAG "$(timestamp): $*"
}

TIMESTAMP=$(timestamp)

# Duplicity sert pour les sauvegardes complètes et incrémentales vers une destination
if [ -z "$URL" ]; then
	log "Pas d'URL définie pour réaliser la sauvegarde"
	exit 1
fi

if [ -n "$1" -a "$1" == "--no-email" ]; then
	shift
	unset EMAIL
fi

let REPORT_STATUS=0
if [ -n "$1" -a "$1" == "--report-status" ]; then
	shift
	let REPORT_STATUS=1
fi

unset INCREMENTAL
if [ -n "$1" -a "$1" == "--incremental" ]; then
	shift
	INCREMENTAL="incr"
fi

[ -d $BASE ] || mkdir -p $BASE
[ -n "$DEV" ] && mount $DEV $BASE >/dev/null 2>&1
pushd $BASE >/dev/null 2>&1 || exit 1
[ -d $BASE/tmp ] || mkdir -p $BASE/tmp

DUPLICITY_OPTS="$OPTIONS $*"

# Pas besoin de l'option full si on gère un dossier dédié par mois
if [ -n "$FULLDELAY" -a -z "$INCREMENTAL" ]; then
	DUPLICITY_OPTS="$DUPLICITY_OPTS --full-if-older-than $FULLDELAY"
fi

# Taille des volumes à utiliser
DUPLICITY_OPTS="$DUPLICITY_OPTS --volsize 100"

# Dossier temporaire à utiliser
DUPLICITY_OPTS="$DUPLICITY_OPTS --tempdir $BASE/tmp"

unset CACHE_OPTS
if [ -n "$CACHE" ]; then
	[ -d "$CACHE" ] || mkdir -p "$CACHE"
	CACHE_OPTS="--archive-dir $CACHE"
fi

if [ -n "$NAME" ]; then
	CACHE_OPTS="$CACHE_OPTS --name $NAME"
fi

H=$(hostname -s)

# Option de journalisation
DUPLICITY_OPTS="$DUPLICITY_OPTS --log-file master-backup-duplicity-$H-$TIMESTAMP.log"

STDOUT_FILE=$(mktemp .master-backup-stdout.XXXXXXXX)

# PASSPHRASE est le secret pour le cryptage avec duplicity
export PASSPHRASE FTP_PASSWORD

# Paramètres HUBIC
unset HISTFILE
unset CLOUDFILES_USERNAME
unset CLOUDFILES_APIKEY
unset CLOUDFILES_AUTHURL
export CLOUDFILES_USERNAME=${HUBICUSER}
export CLOUDFILES_APIKEY=${HUBICPASSWORD}
export CLOUDFILES_AUTHURL="hubic|${HUBICAPPID}|${HUBICAPPSECRET}|${HUBICAPPURLREDIRECT}"

{
	if [ -n "$WHAT" ]; then
		rm -f .FAILURE
		echo
		log "Sauvegarde $H vers $URL"
		echo
		WHERE="${URL}"
		nice duplicity $INCREMENTAL $CACHE_OPTS $DUPLICITY_OPTS $WHAT --exclude / / $WHERE
		ERR=$?
		
		if (( ERR )); then
			log "Sauvegarde $H vers $URL échouée"
			touch .FAILURE
		else
			log "Sauvegarde $H vers $URL réussie"
		fi
		
		# On permet le nettoyage même en cas d'erreur au cas où un reparamétrage sur la
		# taille des sauvegardes corrige une erreur liée à un espace de stockage plein
		if (( HOWMANYKEEPFULL >= 1 )); then
			log "Nettoyage des sauvegardes dans  $URL"
			nice duplicity remove-all-but-n-full $HOWMANYKEEPFULL $CACHE_OPTS --force $WHERE
		fi
	else
		log "Sauvegarde $H vers $URL impossible sans spécifier quoi sauvegarder"
	fi
} 2>&1 | \
{
	# Boucle de chronométrage de la sauvegarde insérant le temps d'exécution de
	# la sauvegarde dans le journal
	let STARTTIME=$(date +%s)
	while read line
	do
		echo $line
	done
	echo
	let STOPTIME=$(date +%s)
	let TOTALMIN=(STOPTIME-STARTTIME)/60 TOTALMOD=(STOPTIME-STARTTIME)%60
	log "Durée totale du processus de backup: $TOTALMIN minutes et $TOTALMOD secondes"
} >$STDOUT_FILE 2>&1

# Vérification du statut de sauvegarde
if [ "$?" -ne 0 -o -e .FAILURE ]; then
	STATUS="FAILED"
	ERR=1
	cp -af $STDOUT_FILE $STDOUT_FILE.last-failed
else
	STATUS="OK"
	ERR=0
fi

if (( REPORT_STATUS )); then
	duplicity collection-status $CACHE_OPTS $DUPLICITY_OPTS ${URL%/}/ >>$STDOUT_FILE
fi

# Le journal de sauvegarde est stocké dans $BASE/.master-backup-stdout.txt
# mais peut être aussi envoyé par email à l'issue de la sauvegarde ou simplement
# être envoyé sur la sortie standard
if [ -n "$EMAIL" ]; then
	[ -n "$EMAILADMIN" ] && MAILOPTION="-c $EMAILADMIN"
	cat $STDOUT_FILE | \
		mail $MAILOPTION -s "[$STATUS] Sauvegarde $H" $EMAIL
else
	cat $STDOUT_FILE
fi
rm -f $STDOUT_FILE

# Archivage des journaux - Rotation sur 9 archives de journaux de 10Mo max
TARBASE="master-backup-log.gz.tar"
MAXSIZE=10000000
MAX=9
for f in *.log
do
	# Rotation des archives
	SIZE=$( stat -c "%s" $TARBASE 2>/dev/null )
	if (( MAX && SIZE > MAXSIZE )); then
		let I=1
		while [ -e "$TARBASE.$I" ]; do (( I++ < MAX-1 )) || break ; done
		while (( I > 1 )); do let I-- ; mv -f "$TARBASE.$I" "$TARBASE.$((I+1))" ; done
		mv -f "$TARBASE" "$TARBASE.$I"
	fi
	# Archivage du journal de duplicity
	if [ -s "$f" ]; then
		gzip -9n $f             || break
		tar rf $TARBASE $f.gz   || break
		rm -f $f.gz
	fi
done

popd >/dev/null 2>&1
[ -n "$DEV" ] && umount $BASE >/dev/null 2>&1

touch $BASE/.done

unset CLOUDFILES_USERNAME
unset CLOUDFILES_APIKEY
unset CLOUDFILES_AUTHURL

exit $ERR
