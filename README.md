<a name=top></a>
'([home](https://github.com/timm/lump/blob/master/README.md#top) 
([&copy;2020](https://github.com/timm/lump/blob/master/LICENSE.md) 
(["Tim Menzies"](http://menzies.us))))
<img width=1 height=25 src="https://github.com/timm/lump/blob/master/etc/img/FFFFFF.png">
<a href="https://github.com/timm/lump/blob/master/README.md#top">
<img src="https://raw.githubusercontent.com/timm/lump/master/etc/img/banner.png" ></a><br>
'(:site ([src](http://github.com/timm/lisp) 
([contrib](https://github.com/timm/lump/blob/master/READEME.md#contribute)
([discuss](https://github.com/timm/lump/issues))))      
&nbsp;&nbsp;:code ([lib](https://github.com/timm/lump/tree/master/src/lib/README.md#top)
([oo](https://github.com/timm/lump/tree/master/src/oo/README.md#top)
([sample](https://github.com/timm/lump/tree/master/src/sample/README.md#top)))))

<img src="https://img.shields.io/badge/purpose-ai%20,%20se-blueviolet"><a 
href="https://github.com/timm/lump/blob/master/LICENSE.md"><img  
   alt="License" src="https://img.shields.io/badge/license-mit-red"></a><a 
href="https://doi.org/10.5281/zenodo.3947026"><img alt="DOI" 
   src="https://zenodo.org/badge/DOI/10.5281/zenodo.3947026.svg" alt="DOI"></a><img 
alt="Platform" src="https://img.shields.io/badge/platform-osx%20,%20linux-lightgrey"><img 
alt="lisp" src="https://img.shields.io/badge/language-sbcl,clisp-blue"><a 
 href="https://travis-ci.org/github/timm/lump"><img alt="tests" 
   src="https://travis-ci.org/timm/lump.svg?branch=master"></a>

<img align=right src="http://www.lisperati.com/lisplogo_fancy_256.png">

Here are all my data mining LISP tricks.

## Install

Install Common Lisp; e.g.:

- Clisp: good for simple scripts and succinct debug information;
- Sbcl: good for speed and verbose debig information

Download [the code](https://github.com/timm/lump/archive/master.zip) and unzip
it.

Test all the `yes_*.lisp` files, looking for failure cases e.g.

    for f in yes_*.lisp; do 
      sbcl --script $f
    done | grep FAIL

## About this code

The file `README.md` is auto-generated from docstrings in the code
(so  do
not edit it manually).

Each file knows its own dependancies (so every file can be tested independently)

- The `yes_*` files are demos/test of everything else (so to understand this
  code, read the `yes_*` files).
- All the other files load code without
  triggering  side-effects (so that code can be loaded as sub-routnines in other
   packages).

All the classes inherits from a  CLOS [thing](oo.lisp) class which:

- Assigns a unique integer `id` to each instance
- Knows how to pretty-print itself (while hiding secret slots; i.e. those starting with 
  the underscore character `_`).

For BASH users, s set of useful shell commands are loaded using 

    . .lump

This code:

- Creates some useful functions; e.g.
  - `doco` :  regenerates `README.md`
- Creates some useful short-cut alias; e.g.
  - `gp` = commit all files, push them back to the web (via git)
  - `reload` = reload `.lump` (usful if you edit that file and want to access the updated
    functionality).
- Ensures that `.gitignore`, `.travis.yml`, `.var/vimrc` `.var/.tumuxrc` exists
- Ensures that `vi` will use `.var/bashrc`  and `tmux` will use `.var/tmuxrc`



# LUMP




-------

## [col.lisp](col.lisp)





<ul>

Code for incrementally managing summaries of  `num`eric or `sym`bolic  
data. `Num`s can report their mean and standard deviation while `Sym`s can
report their mode and entropy.

</ul>





-------

## [got.lisp](got.lisp)



-------

## [is.lisp](is.lisp)



-------

## [k.lisp](k.lisp)



-------

## [macros.lisp](macros.lisp)


### `while (test &body body)`



<ul>

Adding a `while` loop to LISP.

</ul>



### `getr (how obj f &rest fs)`



<ul>

Recursive access to contents.

</ul>



### `? (x &rest fs)`



<ul>

Recursive access to slot instances

</ul>



### `doitems ((one pos lst &optional out) &body body)`



<ul>

Item `one` is found at `pos` in `lst`. Returns `out`.

</ul>




-------

## [my.lisp](my.lisp)


### `my (&rest fs)`



<ul>

getter for globals

</ul>




-------

## [oo.lisp](oo.lisp)


### `defthing (x parent &rest slots)`



<ul>

Succinct class creation

</ul>



### `print-object ((it thing) out)`



<ul>

for things, print all public slots

</ul>




-------

## [os.lisp](os.lisp)


### `klass-slots (it)`



<ul>

what are the slots of a class?

</ul>



### `klass-slot-definition-name (x)`



<ul>

what is a slot's name?

</ul>



### `args `



<ul>

what are the command line args?

</ul>



### `stop `



<ul>

how to halt the program?

</ul>



### `sh (cmd)`



<ul>

Run a shwll command

</ul>




-------

## [readmes.lisp](readmes.lisp)


### `doread ((it f &optional out &key (take #'read)) &body body)`



<ul>

Iterator for running over files or strings.

</ul>



### `readme (dir &optional (s t))`



<ul>

Generate README.md from doco strings from LISP code in a directory.

</ul>




-------

## [rows.lisp](rows.lisp)



-------

## [strings.lisp](strings.lisp)





<ul>

Misc string tricks

</ul>




### `words (s &optional (lo 0) (hi (position , s start (1+ lo))))`



<ul>

Separate a string `s` on commas

</ul>



### `lines 
(s &optional (lo 0)
 (hi
  (position
   
   s start (1+ lo))))`



<ul>

Separate a string `s` on newline.

</ul>



### `with-csv ((line file) &body body)`



<ul>

Return one list per line, words separated by commas.

</ul>




-------

## [yes.lisp](yes.lisp)



-------

## [yes_col.lisp](yes_col.lisp)



-------

## [yes_data.lisp](yes_data.lisp)



-------

## [yes_is.lisp](yes_is.lisp)



-------

## [yes_macros.lisp](yes_macros.lisp)



-------

## [yes_my.lisp](yes_my.lisp)



-------

## [yes_rows.lisp](yes_rows.lisp)



-------

## [yes_test.lisp](yes_test.lisp)

