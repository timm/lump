<a name=top></a>
'([home](https://github.com/timm/lisp/blob/master/README.md#top) 
([&copy;2019](https://github.com/timm/lisp/blob/master/LICENSE.md) 
(["Tim Menzies"](http://menzies.us))))
<img width=1 height=25 src="https://github.com/timm/lisp/blob/master/etc/img/FFFFFF.png">
<a href="https://github.com/timm/lump/blob/master/README.md#top">
<img src="https://raw.githubusercontent.com/timm/lump/master/etc/img/banner.png" ></a><br>
'(:site ([src](http://github.com/timm/lisp) 
([contrib](https://github.com/timm/lump/blob/master/READEME.md#contribute)
([discuss](https://github.com/timm/lisp/issues))))      
&nbsp;&nbsp;:code ([lib](https://github.com/timm/lisp/tree/master/src/lib/README.md#top)
([oo](https://github.com/timm/lisp/tree/master/src/oo/README.md#top)
([sample](https://github.com/timm/lisp/tree/master/src/sample/README.md#top)))))

[![Build Status](https://travis-ci.org/timm/lump.svg?branch=master)](https://travis-ci.org/timm/lump)

Here are all my data mining LISP tricks.

## Install

Install Common Lisp; e.g.:

- Clisp: good for simple scripts and succinct debug information;
- Sbcl: good for speed and verbose debig information

Download [the code](https://github.com/timm/lump/archive/master.zip) and unzip
it.

Test all the `yes_*.lisp` files, looking for failure cases e.g.

    for f in yes_*.lisp; do sbcl --script $f; done | grep FAIL

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


## License

 Copyright (C) 2020 Tim Menzies <timm@ieee.org>

 Everyone is permitted to copy and distribute verbatim or modified 
 copies of this license document, and changing it is allowed as long 
 as the name is changed. 

This program is free software. It comes without any warranty, to
the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The Fuck You Want
To Public License, Version 2, as published by Sam Hocevar. See
http://www.wtfpl.net/ for more details. 

<p align=center>
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE <br>
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 
</p>

1. You just DO WHAT THE FUCK YOU WANT TO.


### FAQ on the License

Can’t you change the wording? It’s inappropriate / childish / not corporate-compliant?

- The WTFPL lets you relicense the work under any other license.

Can I make money with my software using the WTFPL?

- Yes.

By the way, with the WTFPL, can I also…

- Oh but yes, of course you can.

But can I…

- Yes you can.

Can…

- Yes!

