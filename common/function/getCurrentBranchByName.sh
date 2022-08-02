
function getCurrentBranchByName()
{
    branch=$1
    if [ -n "${branch}" ]; then
        echo $branch
    else
        echo $(getCurrentBranch)
    fi
}