#/bin/bash

check_command=check
posix_command=posix
file_raw=$1
file=${file_raw%-int.trace}

if [ "$file_raw" == "$file" ]; then 
  echo "Error: argument does not have extension '-int.trace'";
  exit 1;
fi;

echo "Interpreting $file with check ..."
$check_command -arch linux $file-int.trace > interp_results-$file

echo -e "\nInterpreting $file with posix ..."
$posix_command $file-int.trace -o $file-posix-fs.trace > posix_results-$file

echo -e "\nChecking that posix-results are accepted by specification ..."
$check_command -v -arch linux $file-posix-fs.trace 

