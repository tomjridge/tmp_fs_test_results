#!/bin/bash

# call this script with the argument directory of traces to test test 
# e.g. ./this_script.sh current_tests/open_read_write

test_dir=$1
if [[ ! (-d $test_dir) ]]
then
  echo "Error: argument is not a directory containing trace files";
  exit 1;
fi

date=`date +'%F'`

test_dir_name=`basename $test_dir`
OUTDIR=`mktemp -d --tmpdir=. ${date}_${test_dir_name}_XXX`
cp $test_dir/* $OUTDIR
mkdir $OUTDIR/results

cd $OUTDIR

for file in *.trace; do
   ../run_trace.sh -q $file
# be more verbose
#   ../run_trace.sh $file
   echo "-----------------------------------"
done

echo -e "\ndone!"

exit 0

