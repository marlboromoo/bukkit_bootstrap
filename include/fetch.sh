make_info_url(){
    echo "$CB_INFO_URL/$CB_SLUG_PREFIX$1/$CB_INFO_PARAMATER"
}

get_cb_version(){
    url=$(make_info_url $1)
    curl -s $url | grep -io '<version>.*</version>' | \
        sed -e 's#<version>##g' -e 's#</version>##g' -e 's/[ ]//g'
}

make_download_url(){
    case "$CRAFTBUKKIT_CHANNEL" in
        rb)
            url=$CB_RB
            ;;
        beta)
            url=$CB_BETA
            ;;
        dev)
            url=$CB_DEV
            ;;
        *)
            url=$CB_RB
            ;;
    esac
    echo $url
}

get_cb_jar(){
    curl -# -L -o $(basename $1) $1
}
