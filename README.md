<link href="http://kevinburke.bitbucket.org/markdowncss/markdown.css" rel="stylesheet"></link>

# Testing infrastructure

This document tries to briefly describe the intended way of running tests.
There are 3 main sections:

 - organising tests in directory ``current_tests``
 - running a whole test-suite with ``run_tests.sh``
 - testing a single trace with ``run_trace.sh``
 

# Organising Tests

_Test-suites_ consist essentially of collections of trace files. The
tools `posix` and `check` are used to process these traces.  There may
also be auxiliary documents like text-files with explanations or other
resources however as well. All files belonging to a test-suite with
name `test-suite-name` should be placed in directory
``current_tests/test-suite-name``.  As mentioned these files can be
separated in two groups:

 - trace files, i.e. files with the ending ``.trace``
 - other files
 
## Naming conventions for trace files
Trace files should follow the following naming convention:

	{name}{optional target}-{trace-type}.trace


The ``name`` part can be freely chosen and should describe the tests
inside the trace.

The ``trace-type`` part has to be 
  + ``int`` for INTERP-traces,
  + ``fs`` for FS-traces or 
  +``os`` for OS-traces. 

The ``optional target`` part is optional and usually left empty. If it
is ``-posix`` this test is run only with the tool `posix`, i.e. on the
real file-system. If it is ``-check`` only the tool `check` is
used. Otherwise, both tools are used to run the tests.


Other files can be anything. They should just avoid the ending
``.trace``. They are only copied by the testing-infrastructure and not
processed in any other way.

## Example

The directory ``current_tests/file_descriptors`` contains the following files

 - ``adhoc_file_descriptor_change_tests-int.trace``
 - ``adhoc_lseek_tests-int.trace``
 - ``adhoc_open_multiple_tests-check-os.trace``
 - ``adhoc_open_tests-int.trace``
 - ``adhoc_pread_tests-int.trace``
 - ``adhoc_pwrite_tests-int.trace``
 - ``readme.txt``
 
 This describes a test-suite with name ``file_descriptors`` which
 consists of 6 traces and a file ``readme.txt``, which contains some
 high-level description of the test-suite. Most of these traces are
 INTERP-traces that are intended to be used with both ``posix`` and
 ``check``. However, ``adhoc_open_multiple_tests-check-os.trace`` is
 an OS-trace that is only used with ``check``.


## ``run_tests.sh``

``run_tests.sh`` runs a whole test-suite. It is important that the
current working directory is the same directory `run_tests.sh` is
stored in. Then run a test-suite with ``run_tests.sh
current_tests/my-test-suite`. To run our example suite use e.g.

	run_tests.sh current_tests/file_descriptors
	
``run_tests.sh`` then creates a test-directory, called test-directory
in the following.  The name of this directory consists of the current
date, the name of the suite and a random suffix. Moreover, a
sub-directory ``results`` is created in this test-directory.  It
copies all files belonging to the test-suite in the test-directory and
runs ``run_trace.sh`` on each of the trace files. ``run_trace.sh`` is
explained in detail below.  Essentially, it executes the tests
described by a trace-file and stores the results in sub-directory
``results``.


## ``run_trace.sh``

``run_trace.sh`` is used to run a single trace file. It should be run
while being inside a test-directory. It is important that a
sub-directory ``results`` exists in the current directory, where some
results can be stored. Having met these requirements, ``run_trace.sh
my.trace`` executes the trace ``my.trace``. Adding the option ``-q``,
i.e. running ``run_trace.sh -q my.trace`` runs the trace in quiet
mode.

``run_trace.sh`` behaviour depends on the type of trace. For an
INTERP-trace `my-int.trace`, it interprets the trace with both posix
and and check and stores the results in `results/posix-results-my` and
`results/check-results-my`. Moreover it stores the results of running
posix as a FS-trace `results/posix-results-my-fs.trace`. This FS-trace
is used to confirm with `check` that the results of posix agree with
the specification. If the trace-name ends with `-check` or `-posix`
only this tool is used to execute the trace.

Given an FS- or OS-trace, ``run_trace.sh`` runs `check` and `posix` on
this trace to confirm that the results recorded in the trace agree
with both the specification and posix. In this case, no files are
generated in `results`, since all relevant results are recorded in the
trace anyhow. Again, depending on the name of the trace the execution
of `check` or `posix` might be skipped.


## Troubleshooting

- `check` or `posix` can't be found

   Edit the file ``run_trace.sh`` and modify the variables
   ``check_command`` and ``posix_command`` to point to the location
   of the commands on your system.
   
- ``No such file or directory`` and similar problems

   When running ``run_tests.sh`` make sure your current working
   directory is the root directory of the tests, i.e. the directory
   the script ``run_tests.sh`` is stored in.
   
   Similarly, when running ``run_trace.sh`` make sure you are inside a
   test-directory. This means that the trace you want to run is in the
   current directory and a sub-directory ``results`` exists.





