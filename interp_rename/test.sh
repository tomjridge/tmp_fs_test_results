# first arg is name of test file
export OCAMLRUNPARAM="s=8M,l=8M,i=1M"
cp $1 ./tests
touch started
echo "started"
/tmp/l/bitbucket/fs/fs_test/interp.native -b -m dir_heap tests > interp_test_results
