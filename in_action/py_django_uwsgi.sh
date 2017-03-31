#!/bin/bash

APP_PATH='/ldx/workspace/python/apps/'
PROJ_PATH="${APP_PATH}/py_api"
PY_VENV_PATH='/ldx/workspace/python/venv/py27_django_latest/'
PID_FILE='/var/run/pyapi_wsgi.pid'

if [ $# -ne 1 ];
then
    echo 'Invalid params!'
    exit 1
fi

CMD=$1
if [ ${CMD} = 'start' ];
then
    cd ${PROJ_PATH}
    # 激活虚拟环境
    source ${PY_VENV_PATH}/bin/activate
    uwsgi --ini ./pyapi_uwsgi.ini > ${APP_PATH}/py_api.out 2>&1 &
    last_pid=$!
    if [ ${last_pid} -le 0 ];
    then
        echo 'uwsgi start failed!!'
        exit 1
    fi
    echo "${last_pid}" > ${PID_FILE}
elif [ ${CMD} = 'shutdown' ];
then
    pid=`cat ${PID_FILE}`
    if [ -z "${pid}" ] || [ ${pid} -le 0 ];
    then
        echo "App have not running!!"
        exit 0
    fi
    kill -9 ${pid}
    echo "">${PID_FILE}
    echo "Shutdown success!!"
else
    echo 'Unknown cmd!!'
fi