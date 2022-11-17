
# string to lower case
# param array $1 string
function toLowerCase()
{
    echo `echo "$1" | tr 'A-Z' 'a-z'`
}