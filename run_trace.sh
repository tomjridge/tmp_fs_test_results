#/bin/bash

# this script is intended to check trace files and produce some 
# evidence for later runs
#
# Usage: 
#     myself trace-file 
#
# or for quiet mode
#     myself -q trace-file 


# adapt to fit the dirs in your installation
check_command=check
posix_command=posix


# the default output
out=/dev/stdout

if [[ $1 == "-q" ]]
then
    shift
    out=/dev/null
fi
    
file_raw=$1

if [[ "$file_raw" == *-int.trace ]] 
then
  file=${file_raw%-int.trace}

  if [[ "$file" != *posix ]] 
  then
    echo "Interpreting $file with check ..."
    $check_command -arch linux $file-int.trace | tee results/check_results-$file >> $out
  fi

  if [[ "$file" != *check ]] 
  then
    echo -e "Interpreting $file with posix ..."
    $posix_command $file-int.trace -o results/posix_results-$file-fs.trace | tee results/posix_results-$file >> $out

    if [[ "$file" != *posix ]] 
    then
      echo -e "Checking that posix-results are accepted by specification ..."
      $check_command -arch linux results/posix_results-$file-fs.trace
    fi
  fi;
else 
if [[ ("$file_raw" == *-fs.trace) || ("$file_raw" == *-os.trace) ]] 
then
  file_ty=${file_raw%.trace}

  if [[ ("$file_raw" == *-fs.trace) ]] 
  then
    file=${file_raw%-fs.trace}
  else
    file=${file_raw%-os.trace}
  fi;

  if [[ "$file" != *posix ]] 
  then
    echo "Processing $file with check ..."
    $check_command -arch linux -v $file_ty.trace | tee results/check_results-$file_ty >> $out
  fi;

  if [[ "$file" != *check ]] 
  then
    echo -e "Processing $file with posix ..."
    $posix_command $file_ty.trace -v | tee results/posix_results-$file_ty >> $out
  fi;
else
  echo "Error: argument is not a trace file";
  exit 1;
fi;
fi;


