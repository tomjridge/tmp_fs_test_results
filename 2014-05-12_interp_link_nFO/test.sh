# first arg is name of test file
export OCAMLRUNPARAM="s=8M,l=8M,i=1M"
cp $1 ./tests
touch started
echo "started"
../src_ext/fs/fs_test/interp.native -b true -m dir_heap -arch linux tests > interp_test_results
