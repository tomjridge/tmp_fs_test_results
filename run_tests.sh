#!/bin/bash

date=`date +'%F'`
testdiff=/tmp/l/bitbucket/fs/fs_test/testdiff.native

function doit() {
  posint=$1
  cmd=$2
  testfile=../short_tests/${cmd}.tests
  TMP=`mktemp -d --tmpdir=. _${date}_${posint}_${cmd}_XXX`
  echo "Running ${posint}_${cmd} tests in $TMP"
  cp -R ${posint}_${cmd}/* $TMP
  (cd $TMP && ./test.sh $testfile)  
  result=$TMP
}

# 
# function doit() {
#     echo $1
# }

doit posix rename
TMP2=$result
doit interp rename
TMP1=$result
echo Diffing...
cmd="$testdiff $TMP2/posix_test_results $TMP1/interp_test_results"
echo $cmd > _rename.diff
$cmd >>_rename.diff

exit 0


# posint=interp
# TMP1=`mktemp -d --tmpdir=. _${date}_interp_rename_XXX`
# echo Running i${posint}_rename tests in $TMP1
# cp -R ${posint}_rename/* $TMP1
# (cd $TMP1 && ./test.sh $testfile)
# 
# echo Diffing...
# cmd="$testdiff $TMP2/posix_test_results $TMP1/interp_test_results"
# echo $cmd > _rename.diff
# $cmd >>_rename.diff
