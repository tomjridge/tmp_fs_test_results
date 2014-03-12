# first argument is name of test file
export OCAMLRUNPARAM="s=8M,l=8M,i=1M"
cp $1 ./tests
rm -rf /tmp/tmp2
mkdir /tmp/tmp2
touch tests.started
/tmp/l/bitbucket/fs/fs_test/posix/posix -b true -r /tmp/tmp2 tests >posix_test_results

