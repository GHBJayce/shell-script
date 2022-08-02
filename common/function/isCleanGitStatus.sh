

function isCleanGitStatus()
{
    res=`git status --porcelain`
    if [ -z "$res" ]; then
        echo 1
    else
        echo 0
    fi
}