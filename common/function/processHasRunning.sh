
# 检查进程是否正在运行
# param string $1 进程名称
# param string $2 进程路径
function processHasRunning()
{
    processName=$1
    processDirPath=${2-}
    if [ ! -z "${processDirPath}" ]; then
        searchProcessDirPath="grep \"${processDirPath}\" | "
    fi
    command="ps -ef | ${searchProcessDirPath-} grep \"${processName}\" | grep -v grep | wc -l | xargs echo"
    res=$(eval $command)
    if [ $res -gt 0 ]; then
        echo 1
    else
        echo 0
    fi
}