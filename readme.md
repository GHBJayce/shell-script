
# Daily Shell

Shell script for daily use. Based on [GHBJayce/rerun](https://github.com/GHBJayce/rerun).

## Install

...

## Commands

```BASH
rerun git:checkout  # interactive checkout branch.
# example: rerun git:pick --commits 'sha-1 sha-1 sha-1'
rerun git:pick  # cherry-pick one or more commits.
    --commits
# example: rerun download:image --link /home/smile.txt --config /home/.config
rerun download:image  # batch download image.
    --link  # file with links, one line one link.
    --config # config file. detail see ".config.example" file
# example: rerun service:nginx --action start
rerun service:nginx
rerun service:mysql
rerun service:redis
    --action # support: start|stop|restart
```