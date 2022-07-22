
servicePath=$(findRecordProcessPosition "${serviceName}" '/usr/local' "${cacheFilePath}" "${servicePathCacheKey}")
serviceConfigFilePath=$(findRecordProcessPosition "${serviceConfigFileName}" '/usr/local' "${cacheFilePath}" "${serviceConfigFilePathCacheKey}")
serviceDirPath=$(dirname "${servicePath}" | xargs dirname)

function log()
{
    if [ $1 -eq 0 ]; then
        rerun_log info "${serviceShortName} ${ACTION} successful."
    else
        rerun_log error "${serviceShortName} ${ACTION} fail: $?"
    fi
}

function start()
{
    if [ $(processHasRunning "${serviceShortName}" "${serviceDirPath}") -eq 0 ]; then
        $(${servicePath} ${serviceConfigFilePath} 2>&1)
    fi
    log $?
}

function stop()
{
    ps -ef | grep "${serviceDirPath}" | grep "${serviceShortName}" | grep -v grep | awk '{print $2}' | xargs kill -9
    log $?
}

case $ACTION in
    start)
        start
    ;;
    stop)
        stop
    ;;
    restart)
        start
        stop
    ;;
esac