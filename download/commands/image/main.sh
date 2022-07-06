
startTime=`date +%s`

mkdir -p $saveDirPath
cd $saveDirPath

# total number of read file rows
total=$(wc -l $linkFileDirPath | awk '{print $1}')
current=$total
for imageURL in `cat $linkFileDirPath`
do
    rerun_log info "progress: $current/$total"
    # decreasing
    current=$(($current-1))
    if [[ $imageURL =~ 'http' ]]; then  
        # delete the characters in the link \r
        url=$(echo "$imageURL" | tr -d '\r')
        # peel https://, http://
        picdir=$(echo $url | sed 's/https:\/\///g' | sed 's/http:\/\///g')
        # ##*/ Indicates that all characters on the left of the last / character are deleted from the left, https://github.com/a/c.html Get c.html
        fileName=$(echo ${picdir##*/})
        # %\?* It means to start from the right and delete the first one? All characters to the right of the character, 123 png? Type=3&a=b gets 123 png
        fileName=$(echo ${fileName%\?*})
        
        rerun_log info "current image link: ${imageURL}"
        rerun_log info "image save path: ${saveDirPath}/${fileName}"

        curlOptionProxy=
        curlOptionSshCertificate=
        if [[ -n "${curlOptionProxyIp}" && -n "${curlOptionProxyPort}" ]]; then
            curlOptionProxy="-x ${curlOptionProxyIp}:${curlOptionProxyPort}"
        fi
        if [[ $url =~ https* ]]; then
            curlOptionSshCertificate="-k"
        fi

        curlCommand=`curl -o ${fileName} ${curlOptionSshCertificate} ${url} ${curlOptionProxy} 2>&1 &`
        echo $curlCommand
    fi
done

sumTime=$[ `date +%s` - $startTime ]
rerun_log "completed. total time: ${sumTime}s."