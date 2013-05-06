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
Edit config/setting.sh if needed.
 - `INSTALL_PATH` : path to install CraftBukkit
 - `PURGE_INSTALL`: delete the old installation path instead of rename it
 - `USE_CRAFTBUKKIT_BETA`: use beta version of CraftBukkit
 - `USE_SCRREN_PREFIX`: use 'C-a' instead of 'C-b'
 - `TMUX_SESSION`: session name of tmux
 - `JAVA_OPT`: java option to launch CraftBukkit server

## TODO
 - support other linux distributions. (current only Ubuntu)
 - colorful output
 - update CraftBukkit
 - log rotate
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
