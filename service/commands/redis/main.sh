
servicePath=$(findRecordProcessPosition "${serviceName}" '/usr/local' "${cacheFilePath}" "${servicePathCacheKey}")
serviceConfigFilePath=$(findRecordProcessPosition "${serviceConfigFileName}" '/usr/local' "${cacheFilePath}" "${serviceConfigFilePathCacheKey}")
serviceDirPath=$(dirname "${servicePath}" | xargs dirname)

function log()
{
    if [ $1 -eq 0 ]; then
        rerun_log info "${serviceShortName} ${2} successful."
    else
        rerun_log error "${serviceShortName} ${2} fail: $?"
    fi
}

function start()
{
    if [ $(processHasRunning "${serviceShortName}" "${serviceDirPath}") -eq 0 ]; then
        $($servicePath $serviceConfigFilePath > /dev/null)
    fi
    log $? 'start'
}

function stop()
{
    $(ps -ef | grep "${serviceDirPath}" | grep "${serviceShortName}" | grep -v grep | awk '{print $2}' | xargs kill -9)
    log $? 'stop'
}

case $ACTION in
    start)
        start
    ;;
    stop)
        stop
    ;;
    restart)
        stop
        start
    ;;
esac