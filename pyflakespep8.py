#!/usr/bin/python

###############################################################################
# PYFLAKESPEP8                                                                #
#                                                                             #
# Source: http://people.cs.uct.ac.za/~ksmith/2011/better-python-flymake-integration-in-emacs.html
# Changes: Julio M. Alegria <julio.alegria@ucsp.edu.pe>                       #
# March 3, 2013                                                               #
#                                                                             #
# How to use:                                                                 #
# 1. Install pyflakes and pep8 (either with easy_install or pip).             #
# 2. Set PYFLAKES and PEP8 variables below with both commands full paths.     #
# 3. If you want to use this command to get (on the fly) source code warning  #
#    and error reports, check out the init.el file.                           #
###############################################################################

import commands
import re
import sys


def make_re(*msgs):
    return re.compile('(%s)' % '|'.join(msgs))

PYFLAKES = '/usr/local/bin/pyflakes'
PEP8 = '/usr/local/bin/pep8'

PYFLAKES_IGNORE = make_re('unable to detect undefined names')
PYFLAKES_WARNING = make_re(
    'imported but unused',
    'is assigned to but never used',
    'redefinition of unused',
)
PEP8_IGNORE = ['E501', 'E111']
PEP8_WARNING = make_re('.')


def run(cmd, ignore_re, warning_re):
    output = commands.getoutput(cmd)
    lines = 0
    for line in output.splitlines():
        if ignore_re and ignore_re.search(line):
            continue
        elif ': ' in line and warning_re.search(line):
            line = '%s: WARNING %s' % tuple(line.split(': ', 1))
        print line
        lines += 1
    return lines

if __name__ == '__main__':
    total_lines = 0
    print '### pyflakes ###'
    total_lines += run(PYFLAKES + ' %s' % sys.argv[1],
                       PYFLAKES_IGNORE,
                       PYFLAKES_WARNING)
    print '### pep8 ###'
    pep8_ignore = ' '.join('--ignore=%s' % i for i in PEP8_IGNORE)
    total_lines += run(PEP8 + ' %s --repeat %s' % (pep8_ignore, sys.argv[1]),
                       None,
                       PEP8_WARNING)
    # Exit is 0 if there are no warning/error lines, otherwise, exit is 1.
    sys.exit(bool(total_lines))
