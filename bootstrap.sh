#!/usr/bin/env bash

#= variables ==================================================================
export LANG=C
CWD=$(dirname $0)
SETTING=$CWD/config/setting.sh
VARS=$CWD/include/vars.sh
LOGO=$CWD/include/logo.ascii
. $SETTING
. $VARS

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

purge_install(){
    message "Rename/Purge existing installation"
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
    cb_url=$CB_STABLE
    version=stable
    if [[ "$USE_CRAFTBUKKIT_BETA" == 'true' ]]; then
       cb_url=$CB_BETA
       version=beta
    fi
    echo "Version: $version"
    echo "Please wait ..."
    curl -# -L -o $(basename $cb_url) $cb_url
    check_result "Download fail to complete!"
    ln -s $(basename $cb_url) $BUKKIT_JAR
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
    echo '#!/bin/bash' > $tmp_script
    #. bukkit settings
    echo "MAP_DIRS='$MAP_DIRS'" >> $tmp_script
    echo "LOG_DIR='$LOG_DIR'" >> $tmp_script
    echo "LOG_FILE='$LOG_FILE'" >> $tmp_script
    echo "EVIL_KEY='$EVIL_KEY'" >> $tmp_script
    #. get java settings
    echo "JAVA_OPT='$JAVA_OPT'" >> $tmp_script
    #. get tmux settings
    echo "SESSION='$TMUX_SESSION'" >> $tmp_script
    PREFIX=$SCREEN_PREFIX
    if [[ "$USE_SCRREN_PREFIX" != 'true' ]]; then
        PREFIX=$TMUX_PREFIX
    fi
    echo "PREFIX='$PREFIX'" >> $tmp_script
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

useage(){
    echo "Useage: $(basename $0) [install|update-script] "
}

#= main program ===============================================================

case $1 in
    install)
        INSTALL_PATH=$(strip_slash $INSTALL_PATH)
        show_logo
        #. confirm install
        confirm "This script will install CraftBukkit server, continue?"
        #. check environment
        check_os
        check_packages $REQUIRE_PACKAGE
        #. backup first
        purge_install
        #. install
        prepare_install_path
        prepare_bukkit_script
        cd $INSTALL_PATH
        get_bukkit
        help_msg
        ;;
    update-script)
        show_logo
        prepare_bukkit_script
        help_msg
        ;;
    *)
        useage
        ;;
esac

