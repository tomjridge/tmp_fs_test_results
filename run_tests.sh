#!/bin/bash

date=`date +'%F'`
testdiff=/tmp/l/bitbucket/fs/fs_test/testdiff.native

function doit() {
  local posint=$1
  local cmd=$2
  testfile=../current_tests/${cmd}.tests
  TMP=`mktemp -d --tmpdir=. _${date}_${posint}_${cmd}_XXX`
  echo "Running ${posint}_${cmd} tests in $TMP"
  cp -R ${posint}_template/* $TMP
  (cd $TMP && ./test.sh $testfile)  
  result=$TMP
}

# 
# function doit() {
#     echo $1
# }

cmd=link
doit posix $cmd
TMP2=$result
doit interp $cmd
TMP1=$result
echo Diffing...
cmd="$testdiff $TMP2/posix_test_results $TMP1/interp_test_results"
echo $cmd > _$cmd.diff
$cmd >>_$cmd.diff

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
