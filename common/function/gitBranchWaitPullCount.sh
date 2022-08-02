

function gitBranchWaitPullCount()
{
    remote=${2:-'origin'}
    branch=$1
    lastCommit=`git rev-parse --short HEAD`
    res=`git log --oneline ${remote}/${branch} ^${lastCommit} | wc -l | xargs echo 2>&1`
    if [[ $res =~ 'unknown revision' ]]; then
        echo 0
        return
    fi
    echo $res
}