# Overview

This file tries to give an overview over the OS-level commands that
have been tested and the status of these tests. For command, it is 
described. For each test-suite it is documented, when it was last run
and perhaps some short description of the results is given.


# OS commands

command | test-suites
---------------------------------------------------------------
chdir   | chdir
chmod   | -
chown   | -
close   | file_descriptors
link    | link
lseek   | file_descriptors
mkdir   | mkdir
open    | file_descriptors, open
pread   | file_descriptors
pwrite  | file_descriptors
read    | file_descriptors
readdir | readdir
readlink| symlink
rename  | rename
rmdir   | rmdir
stat    | stat
symlink | symlink
truncate| truncate
umask   | -
unlink  | unlink
write   | file_descriptors


# Test-suites

## chdir
- 2014-06-12 OK
- 2014-06-17 OK, rerun after refactoring

## file_descriptors  
- 2014-05-27 OK
- 2014-06-17 OK, rerun after refactoring

## link
- 2014-05-30 OK
- 2014-06-17 OK, rerun after refactoring

## mkdir             
- 2014-05-27 OK
- 2014-06-17 OK, rerun after refactoring

## open
- 2014-06-02 OK
- 2014-06-17 OK, rerun after refactoring

## readdir
- 2014-06-12 OK, but readdir needs to be changed
- 2014-06-17 OK, rerun after refactoring

## rename
- 2014-05-27 OK
- 2014-05-30 OK
- 2014-06-17 OK, rerun after refactoring

## rmdir
- 2014-05-30 OK
- 2014-06-17 OK, rerun after refactoring

## stat
- 2014-05-27 
  test infrastructure needs improving to compare stat results
- 2014-06-12 OK
  rerun after implementing comparing stat results correctly
- 2014-06-17 OK, rerun after refactoring

## symlink
- 2014-06-13 OK
- 2014-06-17 OK, rerun after refactoring

## truncate
- 2014-05-30 OK
- 2014-06-17 OK, rerun after refactoring

## unlink
- 2014-05-30 OK
- 2014-06-17 OK, rerun after refactoring
