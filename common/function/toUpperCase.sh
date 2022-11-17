
# string to upper case
# param array $1 string
function toUpperCase()
{
    echo `echo "$1" | tr 'a-z' 'A-Z'`
}