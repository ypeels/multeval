#!/usr/bin/python
'''
Space-delimit input from stdout, for character-level segmentation for IWSLT baseline
'''


import sys

for ch in sys.stdin.read().decode('utf8'):

    # no cannot just do this, because you don't want to split the non-Chinese characters
    # ironically, this turned out to be EXACTLY what they did
    #print ' '.join(list(line)),
    
    # first try: space-delimit any non-latin characters
    # http://stackoverflow.com/questions/196345/how-to-check-if-a-string-in-python-is-in-ascii
    # http://stackoverflow.com/questions/255147/how-do-i-keep-python-print-from-adding-newlines-or-spaces
    
    # ugh, this delimits accented Roman letters
    #try:
    #    ch.decode('latin_1')
    #except UnicodeEncodeError:
    
    # nuke all non-zh characters
    #if ord(ch) >= 0x3038:
    #    sys.stdout.write(' ' + ch.encode('utf8') + ' ')
    #elif ch == '\n':
    #    sys.stdout.write('\n')
    #else:
    #    pass#sys.stdout.write(ch.encode('utf8'))
    
    #if ord(ch) >= 0x3038:
    if not ch == '\r': # otherwise line count gets messed up for their gold, but NOT their MT output!?
        sys.stdout.write(ch.encode('utf8') + ' ')
    #else:
    #    sys.stdout.write(ch.encode('utf8'))


