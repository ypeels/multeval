#!/bin/bash

# to-do: take target_lang, raw_gold, raw_moses from command-line input
lang1=en # source
lang2=de # target


testdir=~/Desktop/multeval/my-test/
raw_gold=$testdir/IWSLT14_TED_tst2010_$lang1-$lang2.$lang2
raw_moses=$testdir/IWSLT14.TED.tst2010.$lang1-$lang2.$lang1.tok.trans

multevaldir=$(dirname $0)
tokenizerdir=$multevaldir/tokenizers/europarl

# adapted from MMM's train script
function lowercase {
    output_file=$1.lower
    #echo Lowercasing to $output_file # this fucks up the "return value"
    $tokenizerdir/lowercase.perl < $1 > $output_file
    echo $output_file
}

function tokenize {
    output_file=$1.tok
    #echo Tokenizing to $output_file
    
    ## MMM version
    #cat $1 | \
    #    $tokenizerdir/tokenizer.perl -threads $(grep -c ^processor /proc/cpuinfo) -a -l $lang2 -q | \
    #    $tokenizerdir/deescape-special-chars.perl > \
    #    $output_file
    
    $tokenizerdir/tokenizer.perl -q -l $lang2 < $1 > $output_file
    
    echo $output_file
}

# WIT^3 uses case-sensitive BLEU, README be damned
gold=$(tokenize $raw_gold)
moses=$raw_moses

$multevaldir/multeval.sh eval --refs $gold --hyps-baseline $moses --metrics bleu ter -v 1
