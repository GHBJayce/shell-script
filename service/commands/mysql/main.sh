
servicePath=$(findRecordProcessPosition "${serviceName}" "/usr/local" "${cacheFilePath}" "${servicePathCacheKey}")
serviceDirPath=$(dirname "${servicePath}" | xargs dirname)

command="${servicePath} ${ACTION} 1>&1"
isRunning="processHasRunning \"${serviceShortName}\" \"${serviceDirPath}\""

case $ACTION in
    start)
        if [ $(eval $isRunning) -eq 1 ]; then
            command='echo SUCCESS'
        fi
    ;;
    stop)
        if [ $(eval $isRunning) -eq 0 ]; then
            command='echo SUCCESS'
        fi
    ;;
    restart)
    ;;
esac

commandRes=$(eval $command)
if [[ $commandRes =~ 'SUCCESS' ]]; then
    rerun_log info "${serviceShortName} ${ACTION} successful."
else
    rerun_log error "${serviceShortName} ${ACTION} fail: $?"
fi