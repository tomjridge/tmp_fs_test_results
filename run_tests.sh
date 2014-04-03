#!/bin/bash

# call this script with the argument for the label to test e.g. ./this_script.sh truncate
lbl=$1

date=`date +'%F'`
testdiff=src_ext/fs/fs_test/testdiff.native


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

cmd=$lbl
doit posix $cmd
TMP2=$result
doit interp $cmd
TMP1=$result
echo Diffing...
diffcmd="$testdiff $TMP2/posix_test_results $TMP1/interp_test_results"
echo $diffcmd > _${cmd}.diff
$diffcmd >>_${cmd}.diff


# as a convenience, copy test results to /tmp
cp $TMP2/posix_test_results $TMP1/interp_test_results /tmp

echo "Results are now in files and directories named _.... You may want to rename these (e.g. _truncate.diff to current_diffs/truncate.diff) and add to repo. Alternatively rm -rf _*. Result files are copied to /tmp/posix_test_results and /tmp/interp_test_results"

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
