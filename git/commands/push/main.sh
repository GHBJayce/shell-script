
if [ `isGitDirectory $gitDirectory` -eq 0 ]; then
    rerun_log error "Not a git repository: ${gitDirectory}"
    exit
fi

cd $gitDirectory

case "$branch" in
    all)
        echo 'Pushing all branch.'
        res=$(git push $remote --all 2>&1 &)
        if [[ $res =~ 'Enumerating objects' || $res =~ '* [new branch]' ]]; then
            rerun_log info 'Push successful.'
        elif [[ $res =~ 'Everything up-to-date' ]]; then
            rerun_log warn 'Remote repository branch already latest.'
        else
            res=$(cat <<- EOF
Push failed: $res
EOF
)
            rerun_log error $res
            exit
        fi

        echo -e '\nPushing all tags.'
        res=$(git push $remote --tags 2>&1 &)
        if [[ $res =~ 'Enumerating objects' || $res =~ '* [new tag]' ]]; then
            rerun_log info 'Push successful.'
        elif [[ $res =~ 'Everything up-to-date' ]]; then
            rerun_log warn 'Remote repository tags already latest. '
        else
            res=$(cat <<- EOF
Push failed: $res
EOF
)
            rerun_log error $res
            exit
        fi
    ;;
    *)
        echo "Pushing branch: ${remote}/${branch}"
        res=$(git push -u $remote $branch 2>&1 &)
        if [[ $res =~ 'your current branch is behind' ]]; then
            rerun_log error 'Remote branch different of local branch. Please fix it.'
        elif [[ $res =~ 'Everything up-to-date' ]]; then
            rerun_log warn 'Already up to date.'
        elif [[ $res =~ 'Create a pull request' || $res =~ 'set up to track remote branch' ]]; then
            rerun_log info 'Push successful.'
        else
            res=$(cat <<- EOF
Push failed: $res
EOF
)
            rerun_log error $res
        fi
    ;;
esac
