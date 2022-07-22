
servicePath=$(findRecordProcessPosition "${serviceName}" '/usr/local' "${cacheFilePath}" "${servicePathCacheKey}")
serviceDirPath=$(dirname "${servicePath}" | xargs dirname)

isRunning=$(processHasRunning "${serviceShortName}" "${serviceDirPath}")

command='echo'
case $ACTION in
    start)
        if [ $isRunning -eq 0 ]; then
            command="sudo ${servicePath}"
        fi
    ;;
    stop)
        command="sudo ${servicePath} -s stop"
    ;;
    restart)
        command="sudo ${servicePath}"
        if [ $isRunning -eq 1 ]; then
            command="${command} -s reload"
        fi
    ;;
esac

$(eval $command)
if [ $? -eq 0 ]; then
    rerun_log info "${serviceShortName} ${ACTION} successful."
else
    rerun_log error "${serviceShortName} ${ACTION} fail: $?"
fi