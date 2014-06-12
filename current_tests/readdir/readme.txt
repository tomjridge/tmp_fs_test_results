some very simple tests for readdir

readdir is not implemented correctly currently. The posix function
reads one entry of a open dir-structure. In constrast, this readdir
opens the structure, reads all entries and closes the structure again.
This needs to be worked on in the future.

