#!/bin/sh
set -e
git clone git@github.com:fidlej/alewrap.git
cd alewrap
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DALE_INCLUDE_DIR=../../ale_0.4.4/ale_0_4/src -DALE_LIBRARY=../../ale_0.4.4/ale_0_4/libale.so ..
make
cd ..
ln -s build/alewrap/libalewrap.so

