#! /bin/sh

### BEGIN INIT INFO
# Provides:          wtclasses-examples
# Required-Start:    $all
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the wt-classes examples
### END INIT INFO

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
NAME=wtclasses-examples
DESC='wt-classes examples'
PIDFILE=/var/run/wtclasses-examples/all.pid
APP=/usr/share/doc/libwtclasses/examples/all.wt
USER=www-data
GROUP=www-data

set -e

. /lib/lsb/init-functions

mkdir -p `dirname $PIDFILE`
chown $USER:$GROUP `dirname $PIDFILE`

program_start () {
    start-stop-daemon --start --quiet --background --pidfile $PIDFILE \
    --chuid $USER:$GROUP --exec $APP -- \
    --docroot /usr/share/Wt/ --approot /usr/share/Wt/Wc/ \
    -p $PIDFILE --http-port 50396 --http-address 127.0.0.1 || true
}


program_stop () {
    start-stop-daemon --stop --quiet --pidfile $PIDFILE --exec $APP || true
}

case "$1" in
    start)
        echo -n "Starting $DESC: "
        program_start
        echo "$NAME."
        ;;
    stop)
        echo -n "Stopping $DESC: "
        program_stop
        echo "$NAME."
        ;;
    restart|force-reload|reload)
        echo -n "Restarting $DESC: "
        program_stop
        sleep 1
        program_start
        echo "$NAME."
        ;;
    status)
        status_of_proc -p $PIDFILE "$APP" $NAME
        ;;
    *)
        echo "Usage: $NAME {start|stop|restart|reload|force-reload|status}" >&2
        exit 1
        ;;
esac

exit 0

