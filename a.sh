#!/bin/bash

# to-do: take target_lang, raw_gold, raw_moses from command-line input
lang1=es # source
lang2=en # target


testdir=~/Desktop/multeval/my-test
raw_gold=$testdir/IWSLT14_TED_tst2010_$lang1-$lang2.$lang2
raw_moses=$testdir/IWSLT14.TED.tst2010.$lang1-$lang2.$lang1.tok.trans

multevaldir=$(dirname $0)
tokenizerdir=$multevaldir/tokenizers

function lowercase {
    output_file=$1.lower
    $tokenizerdir/lowercase.perl < $1 > $output_file
    echo $output_file
}

function tokenize {
    output_file=$1.tok
    $tokenizerdir/europarl/tokenizer.perl -q -l $lang2 < $1 > $output_file     
    echo $output_file
}

function split_zh {
    output_file=$1.split
    $tokenizerdir/split_zh_chars.py < $1 > $output_file
    echo $output_file
}


if [ $lang2 = zh ]; then
    # "In contrast to the other language pairs, for English to Chinese character-level scores are reported.
    gold=$(split_zh $raw_gold)
    moses=$(split_zh $raw_moses)
else
    # "case sensitive+punctuation"! WIT^3 uses case-sensitive BLEU, MultEval README be damned
    gold=$(tokenize $raw_gold)
    moses=$raw_moses
fi

$multevaldir/multeval.sh eval --refs $gold --hyps-baseline $moses --metrics bleu ter --ter.punctuation false
