
if [ `isGitDirectory $gitDirectory` -eq 0 ]; then
    rerun_log error "Not a git repository: ${gitDirectory}"
    exit
fi

cd $gitDirectory

case "$branch" in
    all)
        currentBranch=`getCurrentBranch`
        res=$(git fetch -v --multiple $remote 2>&1)
        remoteBranchList=$(git branch -r --format="%(refname:short)" | grep "origin" | grep -v "HEAD" 2>&1)
        for remoteBranch in ${remoteBranchList[@]}; do
            echo -e ''
            pullBranch $remoteBranch
        done
        res=$(git checkout "$currentBranch" 2>&1)
    ;;
    *)
        pullSingleBranch $branch $remote
    ;;
esac