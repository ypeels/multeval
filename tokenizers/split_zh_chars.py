#!/usr/bin/python
'''
Space-delimit input from stdout, for character-level segmentation for IWSLT baseline
'''


import sys

for ch in sys.stdin.read().decode('utf8'):

    # no cannot just do this, because you don't want to split the non-Chinese characters?
    # NO, ironically, this turned out to be EXACTLY what they did
    if not ch == '\r': # otherwise line count gets messed up for their gold, but NOT their MT output!?
        sys.stdout.write(' ' + ch.encode('utf8'))
    
    # http://stackoverflow.com/questions/196345/how-to-check-if-a-string-in-python-is-in-ascii
    # http://stackoverflow.com/questions/255147/how-do-i-keep-python-print-from-adding-newlines-or-spaces
    
    #if ord(ch) >= 0x3038:
    #else:
    #    sys.stdout.write(ch.encode('utf8'))


