export OCAMLRUNPARAM="s=8M,l=8M,i=1M"
cp ../current_tests/rename.tests ./tests
touch started
echo "started"
/tmp/l/bitbucket/fs/fs_test/interp.native -b -m dir_heap -arch linux tests > interp_test_results
