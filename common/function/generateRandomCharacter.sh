
# 生成随机字符
# param string $1 字符长度
function generateRandomCharacter()
{
  length=${1:-10}
  length=$[$length-3]
  res=`openssl rand -base64 ${length}`
  echo ${res//'=='/}
}