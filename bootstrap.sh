#!/usr/bin/env bash

#= includ =====================================================================
export LANG=C
CWD=$(dirname $0)
LOGO=$CWD/include/logo.ascii
_SETTING=$CWD/config/setting.sh
_VARS=$CWD/include/vars.sh
_VERSION=$CWD/include/version.sh
. $_SETTING
. $_VARS
. $_VERSION

#= functions ==================================================================
check_os(){
    message "Check operating system"
    support=false
    for os in $SUPPORT_OS; do
        if [[ -n $(cat /etc/issue | grep -i $os) ]]; then
            support=true
        fi
    done
    if [[ "$support" != 'true' ]]; then
        alert "Only support following OS right now:"
        alert "$SUPPORT_OS"
        exit 0
    else
        okay
    fi
}

check_result(){
    if [[ "$?" != 0 ]]; then
        alert $1
        exit 1
    fi
}

check_premission(){
    check_result "Do not have write permission!"
}

check_packages(){
    message "Check required packages"
    for p in $@; do
        dpkg -L $p >/dev/null 2>&1
        if [[ "$?" != 0 ]]; then
            echo "Missing package $p, use follow cmd to install:"
            echo "sudo apt-get install $p"
            exit 0
        fi
    done
    okay
}

message(){
    line="=========>> "
    echo "$line $1 "
}

alert(){
    echo "$1"
}

okay(){
    echo "Pass!"
}

strip_slash(){
    echo $1 | sed 's#/$##g'
}

purge_installation(){
    message "Backup/Remove existing installation"
    if [[ -d $INSTALL_PATH ]]; then
        if [[ "$PURGE_INSTALL" == 'true' ]]; then
            rm -rf $INSTALL_PATH 2>/dev/null
        else
            mv $INSTALL_PATH{,.$(date +"%s")} 2>/dev/null
        fi
    check_premission
    fi
    okay
}

get_bukkit(){
    message "Get CraftBukkit"
    cb_url=$CB_RB
    version=stable
    case "$CRAFTBUKKIT_CHANNEL" in
        rb)
            cb_url=$CB_RB
            ;;
        beta)
            cb_url=$CB_BETA
            ;;
        dev)
            cb_url=$CB_DEV
            ;;
    esac
    echo "Version: $CRAFTBUKKIT_CHANNEL"
    echo "Please wait ..."
    echo $cb_url
    curl -# -L -o $(basename $cb_url) $cb_url
    check_result "Downloads fail to complete!"
    if [[ ! -f $BUKKIT_JAR ]]; then
        ln -s $(basename $cb_url) $BUKKIT_JAR
    fi
    check_premission
}

prepare_install_path(){
    message "Prepare installation path"
    mkdir $INSTALL_PATH 2>/dev/null
    check_premission
    okay
}

make_bukkit_script(){
    tmp_script=/tmp/cb.sh.$(date +"%s")
    echo -e '#!/bin/bash\n' > $tmp_script
    #. variables and settings
    cat $_VARS >> $tmp_script
    cat $_SETTING >> $tmp_script
    #. tmux settings
    echo "SESSION='$TMUX_SESSION'" >> $tmp_script
    PREFIX=$SCREEN_PREFIX
    if [[ "$USE_SCRREN_PREFIX" != 'true' ]]; then
        PREFIX=$TMUX_PREFIX
    fi
    echo "PREFIX='$PREFIX'" >> $tmp_script
    echo '' >> $tmp_script
    #. extra function
    cat $_VERSION >> $tmp_script
    #. almost done
    cat $BUKKIT_SCRIPT_TEMPLATE >> $tmp_script
    chmod +x $tmp_script
    echo $tmp_script
}

prepare_bukkit_script(){
    message "Prepare CraftBukkit scripts"
    tmp_script=$(make_bukkit_script)
    if [[ -f "$tmp_script" ]]; then
        cp $tmp_script $INSTALL_PATH/$BUKKIT_SCRIPT 2>/dev/null
        check_premission
        rm -f $tmp_script
        okay
    else
        alert "Missing file: $BUKKIT_SCRIPT"
        exit 1
    fi
}

show_cb_versions(){
    message "Check CraftBukkit versions"
    for slug in $CB_RB_SLUG $CB_BETA_SLUG $CB_DEV_SLUG; do
        version=$(get_cb_version $slug)
        echo "$slug: $version"
    done
}

show_logo(){
        clear; cat $LOGO
}

confirm(){
    read -p "$1 (yes/no)" answer
    case $answer in
        yes)
            foo=bar
            ;;
        *)
            echo 'Abort.'
            exit 0
            ;;
    esac
}

help_msg(){
    line='*****'
    echo -e "\n$line Install complete $line"
    echo "Check the installation path: $INSTALL_PATH"
    echo -e "To launch CraftBukkit server:\n$INSTALL_PATH/$BUKKIT_SCRIPT"
}

usage(){
    echo "Usage: $(basename $0) [install|upgrade|check-version|update-script] "
}

#= main program ===============================================================

INSTALL_PATH=$(strip_slash $INSTALL_PATH)
show_logo
case $1 in
    install)
        #. confirm install
        confirm "This script will install CraftBukkit server, continue?"
        #. check environment
        check_os
        check_packages $REQUIRE_PACKAGE
        #. install
        purge_installation
        prepare_install_path
        prepare_bukkit_script
        cd $INSTALL_PATH
        get_bukkit
        help_msg
        ;;
    check-version)
        check_packages $REQUIRE_PACKAGE
        show_cb_versions
        ;;
    update-script)
        prepare_bukkit_script
        help_msg
        ;;
    *)
        usage
        ;;
esac

