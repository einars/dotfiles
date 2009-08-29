#!/usr/bin/python

import sys

verbose = False
all = False

if '-v' in sys.argv:
    verbose = True

if '-a' in sys.argv:
    all = True

n_files = 0
n_failures = 0

for file in sys.argv:

    if file[0] == '-': 
        continue

    n_files = n_files + 1

    try:
        unicode(''.join(open(file)),'utf-8').encode('utf-8')
        if all:
            print '    %s' % file
    except UnicodeDecodeError:
        n_failures = n_failures + 1
        if verbose:
            raise
        else:
            print 'FAIL %s' % file

if n_failures == 0:
    print('Files ok: %d' % n_files)
else:
    print('%d/%d files failed.' % (n_failures, n_files))
