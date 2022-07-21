
commits=($COMMITS)

for item in ${commits[@]}; do
    echo "Current picking commit: ${item}"
    res=$(git cherry-pick $item 2>&1 &)
    if [[ $res =~ 'after resolving the conflicts' ]]; then
        rerun_log warn 'Has conflicts! You can pick it after handling the conflict. Continue?'
        option=$(askChooseOption 'Yes No')
        if [ "$option" == "No" ]; then
            break
        fi
    elif [[ $res =~ 'The previous cherry-pick is now empty' ]]; then
        rerun_log warn 'The commit already in the branch.'
        git cherry-pick --skip
    else
        rerun_log info 'Picked complete.'
    fi
done