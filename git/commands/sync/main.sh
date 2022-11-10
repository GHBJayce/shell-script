
rerun jayce-public/git:pull --directory $gitDirectory --branch all --remote $remote
if [ $? -eq 0 ]; then
  rerun jayce-public/git:push --directory $gitDirectory --branch all --remote $target
fi