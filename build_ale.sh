#!/bin/sh
set -e
wget http://www.arcadelearningenvironment.org/wp-content/uploads/2014/04/ale_0.4.4.zip
unzip ale_0.4.4.zip
cd ale_0.4.4/ale_0_4
make -f makefile.`luajit -e 'if jit.os == "OSX" then print("mac") else print("unix") end'`
