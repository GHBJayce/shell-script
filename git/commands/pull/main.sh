

function pullBranch()
{
    if [ `isCleanGitStatus` -eq 0 ]; then
        rerun_die 'The current branch is not clean, please handle it before operation.'
    fi

    remoteBranch=$1
    branch=${remoteBranch/${remote}\//}
    echo "Switching branch: ${branch}"
    res=$(git checkout -b $branch $remoteBranch 2>&1 &)
    if [[ $res =~ 'Switched to a new branch' ]]; then
        rerun_log info 'Create a new branch.'
        return
    elif [[ $res =~ 'already exists' ]]; then
        res=$(git checkout $branch 2>&1)
    fi

    pullSingleBranch $branch $remote
}

function pullSingleBranch()
{
    remote=$2
    branch=$1

    if [ `hasRemoteGitBranch "$branch" "$remote"` -eq 0 ]; then
        rerun_log warn 'No find remote branch.'
        return
    fi
    if [ `gitBranchWaitPullCount "$branch" "$remote"` -eq 0 ]; then
        rerun_log warn 'Current branch already latest.'
        return
    fi

    echo "Updating branch: ${remote}/${branch}"
    res=$(git pull ${remote} ${branch} 2>&1 &)
    if [[ ${res} =~ 'Already up to date' ]]; then
        rerun_log warn 'Already up to date.'
    elif [[ ${res} =~ 'Updating' ]]; then
        rerun_log info 'Pull successful.'
    elif [[ $res =~ "couldn't find remote" ]]; then
        rerun_log error "Couldn't find remote."
    else
        rerun_log error "Pull fail: ${res}."
    fi
}

if [ `isGitDirectory $gitDirectory` -eq 0 ]; then
    rerun_log error "not a git repository: ${gitDirectory}"
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