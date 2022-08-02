
function getCurrentDirPathByName()
{
    dirPath=$1
    if [ -n "$dirPath" ]; then
        echo $dirPath
    else
        echo $(pwd)
    fi
}