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
    # format="MM"
    #format='mps'
    for f in $format
    do
        if [ $f == 'mps' ]
        then
            mkdir -p $f
            mkdir -p $f/netlib
            wget --no-directories --directory-prefix=$f/netlib --recursive --no-parent http://www.netlib.org/lp/data/
            rm -f $f/netlib/ascii*
            rm -f $f/netlib/changes*
            rm -f $f/netlib/kennington*
            rm -f $f/netlib/minos*
            rm -f $f/netlib/mpc.src*
            rm -f $f/netlib/standgub*
            rm -f $f/netlib/stocfor3*
            rm -f $f/netlib/truss*
            rm -f $f/netlib/nams*
            rm -f $f/netlib/index*
            rm -f $f/netlib/robots.txt*
            rm -f $f/netlib/readme*
        else
            mkdir -p $f
            for l in $sublib
            do
                mkdir -p $f/$l
                wget --no-directories --directory-prefix=$f/$l --recursive --no-parent http://www.cise.ufl.edu/research/sparse/$f/$l/
            done
            rm -f $f/$sublib/index*
            rm -f $f/$sublib/robots.txt
        fi
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
    if [ -d mps ]
    then
        if [ -d mps/netlib ]
        then
            cd mps/netlib
            for p in *
            do
                gunzip $p
            done
            gcc -o emps emps.c
            shopt -s extglob
            ./emps -s !(emps*)
            shopt -u extglob
            cd ../..
        fi
        if [ -d mps/Meszaros ]
        then
            :
        fi
        if [ -d mps/Mittelmann ]
        then
            :
        fi
    fi
fi
