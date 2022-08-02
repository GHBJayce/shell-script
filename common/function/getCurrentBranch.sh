
function getCurrentBranch()
{
    echo $(git rev-parse --abbrev-ref HEAD)
}