export OCAMLRUNPARAM="s=8M,l=8M,i=1M"
cp ../current_tests/rename.tests ./tests
rm -rf /tmp/tmp2
mkdir /tmp/tmp2
touch tests.started
/tmp/l/bitbucket/fs/fs_test/posix/posix -b true -r /tmp/tmp2 tests >posix_test_results

