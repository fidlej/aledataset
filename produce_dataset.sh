#!/bin/sh
set -e

# Generating the frames
ALE_HOME="ale_0.4.4/ale_0_4"
export LD_LIBRARY_PATH="$ALE_HOME"
export DYLD_LIBRARY_PATH="$LD_LIBRARY_PATH"
export LUA_CPATH="alewrap/?.so;;"
export LUA_PATH="alewrap/?/init.lua;;"

luajit util/gen_bw_2014.lua freeway
luajit util/gen_bw_2014.lua pong
luajit util/gen_bw_2014.lua riverraid
luajit util/gen_bw_2014.lua seaquest
luajit util/gen_bw_2014.lua space_invaders

luajit util/split.lua

rm freeway.bin
rm pong.bin
rm riverraid.bin
rm seaquest.bin
rm space_invaders.bin
