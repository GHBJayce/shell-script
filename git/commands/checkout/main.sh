
branchList=$(git branch --list --format="%(refname:short)" 2>&1)
branchName=$(askChooseOption "${branchList[@]}")
git checkout $branchName