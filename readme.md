
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
# example: rerun git:pull --directory '/root/project/hello-world' --branch all
rerun git:pull  # git pull script command.
rerun git:push  # git push script command.
    --directory # absolute directory path of git.
    --branch # branch name. support: all
    --remote # remote name. default: origin.


# example: rerun download:image --link /home/smile.txt --config /home/.config
rerun download:image  # batch download image.
    --link  # file with links, one line one link.
    --config # config file. detail see "common/config/.download.image.config.example" file.


# example: rerun service:nginx --action start
rerun service:nginx
rerun service:mysql
rerun service:redis
rerun service:php-fpm
    --action # support: start|stop|restart
# example: rerun service:batch --services "mysql redis php-fpm" --action start.
rerun service:batch
    --action # support: start|stop|restart
    --services # support: nginx|mysql|redis|php-fpm
```