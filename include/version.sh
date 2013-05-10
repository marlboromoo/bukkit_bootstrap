make_info_url(){
    echo "$CB_INFO_URL/$CB_SLUG_PREFIX$1/$CB_INFO_PARAMATER"
}

get_cb_version(){
    url=$(make_info_url $1)
    curl -s $url | grep -io '<version>.*</version>' | \
        sed -e 's#<version>##g' -e 's#</version>##g' -e 's/[ ]//g'
}
