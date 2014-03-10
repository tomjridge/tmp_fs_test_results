export OCAMLRUNPARAM="s=8M,l=8M,i=1M"
touch without.started
echo "without started"
/tmp/l/bitbucket/fs/fs_test/interp.native -b -m dir_heap tests_without_dump > without_results
touch with.started
echo "with started"
/tmp/l/bitbucket/fs/fs_test/interp.native -b -m dir_heap tests_with_dump > with_results

