#!/bin/bash

date=`date +'%F'`


TMP2=`mktemp -d --tmpdir=. _${date}_posix_rename_XXX`
echo Running posix_rename tests in $TMP2
cp -R posix_rename/* $TMP2
(cd $TMP2 && ./test.sh)

TMP1=`mktemp -d --tmpdir=. _${date}_interp_rename_XXX`
echo Running interp_rename tests in $TMP1
cp -R interp_rename/* $TMP1
(cd $TMP1 && ./test.sh)


