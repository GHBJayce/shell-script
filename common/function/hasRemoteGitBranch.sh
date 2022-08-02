

function hasRemoteGitBranch()
{
    remote=${2:-'origin'}
    branch=$1
    res=`git rev-parse --verify "${remote}/${branch}"`
    if [[ $res =~ 'fatal' ]]; then
        echo 0
    else
        echo 1
    fi
}