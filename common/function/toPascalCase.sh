
# string to pascal case
# param array $1 string
function toPascalCase()
{
    echo `echo "$1" | perl -pe 's/(^|-|_)(\w)/\U\2/g'`
}