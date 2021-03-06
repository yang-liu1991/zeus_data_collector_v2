SION=__BUILD_VERSION__
export VERSION
CURRDIR=`dirname "$0"`
BASEDIR=`cd "$CURRDIR"; cd ..; pwd`
# crontab 运行账户环境配置
source /etc/profile
NAME="zeus_data_collector"
CMD="zeus_data_collector_main.py"
if [ "$1" = "-d" ]; then
    shift
    EXECUTEDIR=$1
    shift
else
    EXECUTEDIR=$BASEDIR
fi
if [ "$1" = "-t" ]; then
    shift
    TIME=$1
    shift
else
    TIME=$(date +"%Y-%m-%d %H:%M:%S")
fi
if [ ! -d "$EXECUTEDIR" ]; then
    echo "ERROR: $EXECUTEDIR is not a dir"
    exit
fi

if [ "$1" = "-tp" ]; then
    shift
    TOPIC=$1
    shift
else
    TOPIC="break_data"
fi

if [ ! -d "$EXECUTEDIR"/conf ]; then
    echo "ERROR: could not find $EXECUTEDIR/conf/"
    exit
fi
if [ ! -d "$EXECUTEDIR"/logs ]; then
    mkdir "$EXECUTEDIR"/logs
fi
cd "$EXECUTEDIR"
echo "starting $CMD ..."
/usr/local/bin/python "$BASEDIR"/lib/"$CMD" -d "$EXECUTEDIR" -t "$TIME" -tp "$TOPIC"


