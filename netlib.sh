#!/bin/bash
if [ "$1" = 'clean' ]
then
    rm -rf netlib/*
    rmdir netlib
    rm -rf netlib_m/*
    rmdir netlib_m
else
    mkdir -p netlib
    wget --no-directories --directory-prefix=netlib --recursive --no-parent --reject ascii,changes,index*,kennington,minos,mpc*,robots.txt,stocfor3*,truss,readme,nams* http://www.netlib.org/lp/data/
    rm netlib/robots.txt
    mkdir -p netlib_m
    wget -O netlib_m/lp_matlab.tar.gz http://www.math.ufl.edu/~hager/LPTest/MATLAB/LP_MATLAB.tar.gz
    tar -C netlib_m --strip=1 -xvzf netlib_m/lp_matlab.tar.gz
    rm netlib_m/lp_matlab.tar.gz
fi
