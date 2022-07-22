
# 查找进程位置
# param string $1 进程名称
# param string $2 进程路径
function askSearchProcessPosition()
{
    processName=$1
    processDirPath=${2-/}
    options=$(searchProcessPosition "${processName}" "${processDirPath}")
    if [ -z "${options}" ]; then
        read -r -p $'Process service not found in the "'${processDirPath}$'". \n Please re-enter the path to search: ' searchServiceDirPath
        options=$(askSearchProcessPosition "${processName}" "${searchServiceDirPath}")
    fi
    echo ${options[@]}
}