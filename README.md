# BukkitBootstrap
Script to setup/manage CraftBukkit server on linux.
```
 ___      _   _   _ _   ___           _      _                 
| _ )_  _| |_| |_(_) |_| _ ) ___  ___| |_ __| |_ _ _ __ _ _ __ 
| _ \ || | / / / / |  _| _ \/ _ \/ _ \  _(_-<  _| '_/ _` | '_ \
|___/\_,_|_\_\_\_\_|\__|___/\___/\___/\__/__/\__|_| \__,_| .__/
                                                         |_|   
```
## Requirments 
 - [BASH] [1]
 - [cURL] [2]
 - [tmux] [3]
 - Perl
 - JRE
                                                                                
## Install
```
git clone https://github.com/marlboromoo/bukkit_bootstrap.git
cd bukkit_bootstrap
./bootstrap.sh 

```
## Configuration
Edit `config/setting.sh` if needed:
 - `INSTALL_PATH` : path to install CraftBukkit
 - `PURGE_INSTALL`: delete the old installation path instead of rename it
 - `USE_CRAFTBUKKIT_BETA`: use beta version of CraftBukkit
 - `USE_SCRREN_PREFIX`: use 'C-a' instead of 'C-b'
 - `TMUX_SESSION`: session name of tmux
 - `JAVA_OPT`: java option to launch CraftBukkit server

## Useage
Control script for bukkit server.
```
~/craftbukkit/craftbukkit.sh 
Useage: craftbukkit.sh [CMD]

Available CMDs:
  start			Start bukkit server.
  attach		Attach bukkit server console.
  console		Alias for attach.
  stop			Stop bukkit server. (graceful)
  restart		Restart bukkit server. (graceful)
  kill			Kill the bukkit server.
  cmd "MY COMMAND"	Send command to bukkit server.
  plainlog "LOGFILE"	Strip color code from log file.
  log-rotate		Log rotate.
  regen-end		Stop server, delete world_the_end dir, start server.
  remake-world		Stop server, rename map directories, start server.
  purge-world		Stop server, delete map directories, start server.
 
```

## Daily Jobs
Add follow settings in `/etc/crontab`.
```
# m h dom mon dow user	command
59 23	* * *   minecraft /home/minecraft/craftbukkit/craftbukkit.sh log-rotate
51 0	* * *   minecraft /home/minecraft/craftbukkit/craftbukkit.sh cmd "say Server will restart in 10 minute."
56 0	* * *   minecraft /home/minecraft/craftbukkit/craftbukkit.sh cmd "say Server will restart in 5 minute."
0  1	* * *   minecraft /home/minecraft/craftbukkit/craftbukkit.sh cmd "say Server will restart in 1 minute."
1  1	* * *   minecraft /home/minecraft/craftbukkit/craftbukkit.sh regen-end
#1  1	* * *   minecraft /home/minecraft/craftbukkit/craftbukkit.sh restart
```

## TODO
 - support other linux distributions. (current only Ubuntu)
 - colorful output
 - update CraftBukkit
 - report server status
 - ...

## Author                                                                       
Timothy.Lee a.k.a MarlboroMoo.                                                  
                                                                                
## License                                                                      
Released under the [MIT License] [4].                                           
                                                                                
  [1]: http://tiswww.case.edu/php/chet/bash/bashtop.html "BASH"
  [2]: http://curl.haxx.se/ "cURL"
  [3]: http://tmux.sourceforge.net/ "tmux"
  [4]: http://opensource.org/licenses/MIT   "MIT License"
