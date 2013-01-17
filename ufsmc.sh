#!/bin/bash
if [ "$1" = '-h' ] || [ "$1" = '--help' ]
then
    echo "This script will download the test problem from http://www.cise.ufl.edu/."
    echo -e "To remove the test problem use\n\n\t\$ ./ufsmc.sh clean."
elif [ "$1" = 'clean' ]
then
    rm -rf mat
    rm -rf MM
    rm -rf rb
else
    # format="mat MM rb"
    sublib="LPnetlib Meszaros Mittelmann"
    format="MM"
    for f in $format
    do
        mkdir -p $f
        for l in $sublib
        do
            mkdir -p $f/$l
            wget --no-directories --directory-prefix=$f/$l --recursive --no-parent http://www.cise.ufl.edu/research/sparse/$f/$l/
        done
        rm -f $f/$sublib/index*
        rm -f $f/$sublib/robots.txt
    done
    if [ -d mat ]
    then
        if [ -d mat/LPnetlib ]
        then
            :
        fi
        if [ -d mat/Meszaros ]
        then
            :
        fi
        if [ -d mat/Mittelmann ]
        then
            :
        fi
    fi
    if [ -d MM ]
    then
        if [ -d MM/LPnetlib ]
        then
            cd MM/LPnetlib
            for p in *
            do
                tar xvfz $p
                rm -f $p
            done
            cd ../..
        fi
        if [ -d MM/Meszaros ]
        then
            cd MM/Meszaros
            for p in *
            do
                tar xvfz $p
                rm -f $p
            done
            cd ../..
        fi
        if [ -d MM/Mittelmann ]
        then
            cd MM/Mittelmann
            for p in *
            do
                tar xvfz $p
                rm -f $p
            done
            cd ../..
        fi
    fi
    if [ -d rb ]
    then
        if [ -d rb/LPnetlib ]
        then
            :
        fi
        if [ -d rb/Meszaros ]
        then
            :
        fi
        if [ -d rb/Mittelmann ]
        then
            :
        fi
    fi
fi
