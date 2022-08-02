
function isGitDirectory()
{
    gitDirectory=$1
    cd $gitDirectory
    res=$(git rev-parse --is-inside-work-tree 2>&1)
    if [[ $res =~ 'not a git repository' ]]; then
        echo 0
    else
        echo 1
    fi
}