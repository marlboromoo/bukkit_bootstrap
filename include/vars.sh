#!/usr/bin/env bash

SUPPORT_OS='ubuntu'
REQUIRE_PACKAGE='git tmux openjdk-7-jre perl'
CB_STABLE=http://dl.bukkit.org/latest-rb/craftbukkit.jar
CB_BETA=http://cbukk.it/craftbukkit-beta.jar
BUKKIT_JAR='craftbukkit.jar'
BUKKIT_SCRIPT='craftbukkit.sh'
BUKKIT_SCRIPT_TEMPLATE='./template/craftbukkit'
SCREEN_PREFIX='C-a'
TMUX_PREFIX='C-b'
WORLD_WORLD='world'
WORLD_NETHER='world_nether'
WORLD_END='world_the_end'
MAP_DIRS="$WORLD $WORLD_NETHER $WORLD_END"
LOG_DIR='log'
LOG_FILE='server.log'
EVIL_KEY='C-c'
MAX_TRY='20'
