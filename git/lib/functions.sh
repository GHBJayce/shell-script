
. "$RERUN" || {
    echo >&2 "ERROR: Failed sourcing rerun function library: \"$RERUN\""
    return 1
}

rerun_check_include_common_function

[[ $# = 1 ]] || rerun_option_usage

if [[ -r "$RERUN_MODULE_DIR/commands/$1/options.sh" ]]
then
    . "$RERUN_MODULE_DIR/commands/$1/options.sh" || {
        rerun_die "Failed loading options parser."
    }
fi


