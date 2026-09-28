#!/bin/bash
#
# Calculates the coverage of a set of PNG files. Pass the PNG file as
# arguments. If no arguments are specified, it uses the PNG files in
# the seed-images/ directory. 

if [ ! -f ./pngtest ] ; then
        echo "usage: run in the libpng directory containing pngtest"
        exit 1 
fi 

rm -f *.gcda pngout.png

if [ "$#" -gt 0 ] ; then
        echo "testing $# command-line arguments"
        for file in $* ; do
                ./pngtest $file >& /dev/null 
        done 
else 
        echo "testing `ls seed-images/* -1 | wc -l` seed-images/ files"
        for file in seed-images/* ; do
                ./pngtest $file >& /dev/null 
        done 
fi 

gcov *.c 2> /dev/null | grep "Lines executed" | tail -1
