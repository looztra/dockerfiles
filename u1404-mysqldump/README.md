What?
=====

* A simple ubuntu based container with mysql client
* 2 volumes, /var/mysqldump where dumps will be stored and /etc/myscripts where the script `dump_dump_dump.sh` script will be found
* 1 crontab that execute the `dump_dump_dump.sh` script everyday
