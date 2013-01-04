#!/bin/bash
if [ "$1" = '-h' ] || [ "$1" = '--help' ]
then
    echo "This script will download the test problem from http://www.cise.ufl.edu/."
    echo -e "To remove the test problem use\n\n\t\$ ./ufsmc.sh clean."
elif [ "$1" = 'clean' ]
then
    rm -rf mat
    rm -rf mm
    rm -rf rb
else
    # format="mat mm rb"
    # sublib="LPnetlib Meszaros Mittelmann"
    format="mat"
    sublib="LPnetlib"
    for f in $format
    do
        mkdir -p $f
        for l in $sublib
        do
            mkdir -p $f/$l
            wget --no-directories --directory-prefix=$f/$l --recursive --no-parent http://www.cise.ufl.edu/research/sparse/$f/$l/
        done
    done
fi
