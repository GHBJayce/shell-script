
# string to snake case
# param array $1 string
function toSnakeCase()
{
    echo `echo "$1" | perl -pe 's/(^|-|_)(\w)/_\2/g' | perl -pe 's/^_//g'`
}