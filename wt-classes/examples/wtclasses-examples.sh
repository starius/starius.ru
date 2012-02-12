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

set -e

. /lib/lsb/init-functions

mkdir -p `dirname $PIDFILE`
chown www-data:www-data `dirname $PIDFILE`

case "$1" in
    start)
        echo -n "Starting $DESC: "

        start-stop-daemon --start --quiet --background --pidfile $PIDFILE \
        --chuid www-data:www-data --exec $APP -- --docroot /usr/share/Wt/ \
        -p $PIDFILE --http-port 50396 --http-address 127.0.0.1 || true

        echo "$NAME."
        ;;
    stop)
        echo -n "Stopping $DESC: "

        start-stop-daemon --stop --quiet --pidfile $PIDFILE --exec $APP || true

        echo "$NAME."
        ;;
    restart|force-reload|reload)
        echo -n "Restarting $DESC: "

        start-stop-daemon --stop --quiet --pidfile $PIDFILE --exec $APP || true

        sleep 1

        start-stop-daemon --start --quiet --background --pidfile $PIDFILE \
        --chuid www-data:www-data --exec $APP -- --docroot /usr/share/Wt/ \
        -p $PIDFILE --http-port 50396 --http-address 127.0.0.1 || true

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

