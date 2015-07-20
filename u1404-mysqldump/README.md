What?
=====

* A simple ubuntu based container with mysql client
* 2 volumes, /var/mysqldump where dumps will be stored and /etc/myscripts where the script `dump_dump_dump.sh` script will be found
* 1 crontab that execute the `dump_dump_dump.sh` script everyday

Inspiration
===========

* the supervisor integration comes from https://github.com/raphiz/docker-ubuntu-cron (thanks!)

License
=======

* files for this image are under the MIT license as they mostly come from https://github.com/raphiz/docker-ubuntu-cron
