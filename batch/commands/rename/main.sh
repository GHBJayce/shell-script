
fileList=`ls ${directory}`
for item in ${fileList[@]}; do
  if [ -f "${directory}/${item}" ]; then
    fileExtend=${item##*.}
    if [ $MODE == 'random' ]; then
      fileNewName=`generateRandomCharacter`
      fileNewName=${fileNewName//\//-}
    fi
    newFilePath="${directory}/${fileNewName}.${fileExtend}"
    rerun_log info "'${directory}/${item}' was renamed to '${newFilePath}'"
    `mv ${directory}/${item} ${newFilePath}`
  fi
done