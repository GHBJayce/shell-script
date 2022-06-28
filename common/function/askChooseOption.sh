
# 用户交互相关

# 询问用户选择选项
# param array $1 选项列表
function askChooseOption()
{
    options=($1)
    optionsLen=${#options[@]}
    # echo $optionsLen

    if [ $optionsLen -eq 1 ]; then
        chooseOption=$options
    elif [ $optionsLen -ge 2 ]; then
        # 换行符 $'\x0a、\n'
        select var in ${options[@]}; do
            break;
        done
        chooseOption=$var
    else
        echo '未知异常'
    fi

    echo $chooseOption
}