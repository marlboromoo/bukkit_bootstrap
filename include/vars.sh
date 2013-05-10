#!/usr/bin/env bash

SUPPORT_OS='ubuntu'
REQUIRE_PACKAGE='git tmux openjdk-7-jre perl mawk sed curl'
CB_DOWNLOAD_URL='http://cbukk.it'
CB_RB="$CB_DOWNLOAD_URL/craftbukkit.jar"
CB_BETA="$CB_DOWNLOAD_URL/craftbukkit-beta.jar"
CB_DEV="$CB_DOWNLOAD_URL/craftbukkit-dev.jar"
CB_INFO_URL='http://dl.bukkit.org/api/1.0/downloads/projects/craftbukkit/view'
CB_INFO_PARAMATER='?_accept=application%2Fxml'
CB_SLUG_PREFIX='latest-'
CB_RB_SLUG='rb'
CB_BETA_SLUG='beta'
CB_DEV_SLUG='dev'
BUKKIT_JAR='craftbukkit.jar'
BUKKIT_SCRIPT='craftbukkit.sh'
BUKKIT_SCRIPT_TEMPLATE='./template/craftbukkit'
SCREEN_PREFIX='C-a'
TMUX_PREFIX='C-b'
WORLD_WORLD='world'
WORLD_NETHER='world_nether'
WORLD_END='world_the_end'
MAP_DIRS="$WORLD_WORLD $WORLD_NETHER $WORLD_END"
LOG_DIR='log'
LOG_FILE='server.log'
EVIL_KEY='C-c'
MAX_TRY='20'
