
# 查找进程位置
# param string $1 进程名称
# param string $2 进程路径
function searchProcessPosition()
{
    processName=$1
    processDirPath=${2-/}
    options=$(find ${processDirPath} -name "${processName}" -type f 2>/dev/null &)
    echo ${options[@]}
}