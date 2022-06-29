
rerun_options_parse() {

    unrecognized_args=()

    while (( "$#" > 0 ))
    do
        OPT="$1"
        case "$OPT" in

            -\?|--help)
                rerun_option_usage
                exit 2
                ;;
            *)
              unrecognized_args+=("$OPT")
              shift
              ;;
        esac
    done

    if [ ${#unrecognized_args[@]} -gt 0 ]; then
      export _CMD_LINE="${unrecognized_args[@]}"
    fi
    return 0
}

: ${_CMD_LINE:=}


