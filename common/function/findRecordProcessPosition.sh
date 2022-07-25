
# 查找并记录进程位置
# param string $1 进程名称
# param string $2 进程路径
# param string $3 缓存文件路径
# param string $4 缓存key名称
function findRecordProcessPosition()
{
    processName=$1
    processDirPath=${2-/}
    cacheFilePath=$3
    cacheKey=$4

    if [ ! -f $cacheFilePath ]; then
        dirname $cacheFilePath | xargs mkdir -p
        touch $cacheFilePath
    fi

    servicePath=$(rerun_config_get "${cacheFilePath}" "${cacheKey}")
    if [ -z $servicePath ]; then
        options=$(askSearchProcessPosition "${processName}" "${processDirPath}")
        servicePath=$(askChooseOption "${options[@]}")
        rerun_config_set "${cacheFilePath}" "${cacheKey}=${servicePath}"
    fi
    if [ ! -f "${servicePath}" ]; then
        rerun_config_set "${cacheFilePath}" "${cacheKey}="
        servicePath=$(findRecordProcessPosition "${processName}" "${processDirPath}" "${cacheFilePath}" "${cacheKey}")
    fi
    echo $servicePath
}