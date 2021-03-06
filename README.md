<a name=top></a>
<p align=center>
<a href="https://github.com/timm/lump/blob/master/README.md#top">home</a> ::
<a href="https://github.com/timm/lump/blob/master/READEME.md#contribute">contribute</a> ::
<a href="https://github.com/timm/lump/issues">issues</a> ::
<a href="https://github.com/timm/lump/blob/master/LICENSE.md">&copy;2020<a> by <a href="http://menzies.us">Tim Menzies</a>
</p>

<h1 align=center> LUMP v0.1<br>(print (list (of (some :LISP "tricks")))) </h1>

<p align=center>
<img src="https://imgs.xkcd.com/comics/lisp_cycles.png"><br>
<img src="https://img.shields.io/badge/purpose-ai%20,%20se-blueviolet"> <a 
href="https://github.com/timm/lump/blob/master/LICENSE.md"> <img  
   alt="License" src="https://img.shields.io/badge/license-mit-red"></a> <a 
  href="https://zenodo.org/badge/latestdoi/289524083"> <img 
  src="https://zenodo.org/badge/289524083.svg" alt="DOI"></a> <img 
alt="Platform" src="https://img.shields.io/badge/platform-osx%20,%20linux-lightgrey"> <img 
alt="lisp" src="https://img.shields.io/badge/language-sbcl,clisp-blue"> <a 
 href="https://travis-ci.org/github/timm/lump"><img alt="tests" 
   src="https://travis-ci.org/timm/lump.svg?branch=master"></a>
</p> 



## How to install LUMP

1. Install Common Lisp; e.g.:
  - Clisp: good for simple scripts and succinct debug information;
  - Sbcl: good for speed and verbose debig information
2.  Download [the code](https://github.com/timm/lump/archive/master.zip) and unzip
it.
3. Test all the `yes_*.lisp` files, looking for failure cases e.g.


```sh
for f in yes_*.lisp; do 
   sbcl --script $f
done | grep FAIL
```

## About the code

In this code:

- All the tests are in `src/yes_*.lisp` files
-- The file `README.md` is auto-generated from docstrings in the code
(so  do
not edit it manually).
- For BASH users, a set of useful shell commands are loaded using 

```sh
. etc/lump
```

This code

- Ensures that `.gitignore`, `.travis.yml`, `.var/vimrc` `.var/.tumuxrc` exists
- Ensures that `vi` will use `.var/bashrc`  and `tmux` will use `.var/tmuxrc`

To see the command defined by `etc/lump`, after doing `. etc/lump` then:

    usage

## List of Tricks


- **One-file Config:**
Everything I need to configure is controlled in one file `etc/lump`.
- **Auto-generation of `defsystem.lisp`:**
See the `system` command in `etc/lump`.
- **Auto-generation of documentation:**
The file `src/readmes.lisp` converts LISP code into markdown documentation.
- **Micro-testing:**: Each file knows its own dependancies (so every file can be tested independently)
  - The `src/yes_*` files are demos/test of everything else (so to understand this
    code, read the `src/yes_*` files).
  -   All the other files load code without
    triggering  side-effects (so that code can be loaded as sub-routnines in other
   packages).

### Simpler Class Creation, Printing
I find the default `defclass` syntax tedious so my `defthing` alternative is much simpler.
So


```lisp
(defthing klass super (slot1 init1) (slot2) (slot3 0))
```

Instead of

```lisp
 (declass klass (super) 
   ((slot1 :initform "init1" :init-arg :slot1)
    (slot2                   :init-arg :slot2)
    (slot3 :initform 0       :init-arg :slot3)))
```
Two more details about `thing`s: 

- `Thing` classes know how to pretty-print itself (while hiding secret slots; i.e. those starting with 
  the underscore character `_`).
-  On creation, `defthing` assigns a unique integer `id` to each instance.

## Code Documentation

The following details are extracted from my code's docstrings.



## [bins.lisp](src/bins.lisp)




<ul>

Discretizing and ranking columns of data.

</ul>





<ul>

A `bin` is some subrange within the values of a column.
These are defined by the column number
the refer too, and the min and max value in each bin.
These can also be e ranked according to how well they
predict for some target class.

</ul>



### selects ((i numbin) row)


<ul>

Does this `row` have a value that falls into this bin?

</ul>


### selects ((i symbin) row)


<ul>

Does this `row` have a value that falls into this bin?

</ul>


### score ((i bin))


<ul>

Updates this bin's `score` for how well it predicts 
  for the class. If the target and everything else
  occurs at frequency my1 my2 and in this range 
  see the target class at frequency al1 all2, then
  `n= all1+all2` and `best = b = my1/n`, and `rest=r=m2/n`
  and this range's score is `b^2/(b+r)`.

</ul>


### join ((i bin) (j bin))


<ul>

Return a new range that stretches across `i` and `j`.

</ul>


### add ((i bin) y)


<ul>

Update how often a bin sees the target class (or otherwise).

</ul>



## [col.lisp](src/col.lisp)




<ul>

Summarizing columns of data.

</ul>





<ul>

Columns can be either `num`eric or `sym`bolic
data. `Num`s can report their mean and standard deviation while `Sym`s can
report their mode and entropy.

</ul>




## [is.lisp](src/is.lisp)




<ul>

Define bunch of magic symbols.

</ul>




## [lump.lisp](src/lump.lisp)




<ul>

Load control (never load the same thing twice).

</ul>




## [macros.lisp](src/macros.lisp)




<ul>

Useful macros.

</ul>



### while (test &body body)


<ul>

Adding a `while` loop to LISP.

</ul>


### getr (how obj f &rest fs)


<ul>

Recursive access to contents.

</ul>


### ? (x &rest fs)


<ul>

Recursive access to slot instances

</ul>


### do-hash ((k v h &optional out) &body body)


<ul>

Set key `k` and value `v` to items in hash. Returns `out`.

</ul>


### doitems ((one pos lst &optional out) &body body)


<ul>

Item `one` is found at `pos` in `lst`. Returns `out`.

</ul>



## [misc.lisp](src/misc.lisp)




<ul>

Misc stuff that belongs nowhere else.

</ul>




## [my.lisp](src/my.lisp)




<ul>

Define globals.

</ul>



### my (&rest fs)


<ul>

getter for globals

</ul>



## [oo.lisp](src/oo.lisp)




<ul>

Simpler OO in LISP.

</ul>



### defthing (x parent &rest slots)


<ul>

Succinct class creation

</ul>


### print-object ((object hash-table) stream)


<ul>

Pretty print hash tables.

</ul>


### print-object ((it thing) out)


<ul>

For `thing` classes, print all public slots

</ul>



## [os.lisp](src/os.lisp)




<ul>

Operating system specific code.

</ul>



### klass-slots (it)


<ul>

what are the slots of a class?

</ul>


### klass-slot-definition-name (x)


<ul>

what is a slot's name?

</ul>


### args 


<ul>

what are the command line args?

</ul>


### stop 


<ul>

how to halt the program?

</ul>


### sh (cmd)


<ul>

Run a shwll command

</ul>



## [readmes.lisp](src/readmes.lisp)




<ul>

Generate ../README.md from docstrings.

</ul>



### doread ((it f &optional out &key (take #'read)) &body body)


<ul>

Iterator for running over files or strings.

</ul>


### readme (&optional (s t))


<ul>

Generate README.md from doco strings from LISP code in a directory.

</ul>



## [rows.lisp](src/rows.lisp)




<ul>

Manage rows of data, plus summaries of each col.

</ul>



### add ((i rows) lst)


<ul>

simply add one `lst` of data to `i`

</ul>


### adds ((i rows) lst)


<ul>

Add N things, skipping any `ignore?`ed columns.

</ul>



## [sandbox.lisp](src/sandbox.lisp)




<ul>

Sandbox playpen. Ignore.

</ul>




## [strings.lisp](src/strings.lisp)




<ul>

Misc string tricks

</ul>



### words (s &optional (lo 0) (hi (position , s start (1+ lo))))


<ul>

Separate a string `s` on commas

</ul>


### lines (s &optional (lo 0)
           (hi
            (position 

                      s start (1+ lo))))


<ul>

Separate a string `s` on newline.

</ul>


### with-csv ((line file) &body body)


<ul>

Return one list per line, words separated by commas.

</ul>



## [yes.lisp](src/yes.lisp)




<ul>

A simple test engine.

</ul>




## [yes_bins.lisp](src/yes_bins.lisp)




<ul>

Tests for the test engine `bins.lisp`.

</ul>




## [yes_col.lisp](src/yes_col.lisp)




<ul>

Tests for `col.lisp`.

</ul>




## [yes_data.lisp](src/yes_data.lisp)




<ul>

Data for tests.

</ul>




## [yes_is.lisp](src/yes_is.lisp)




<ul>

Tests for `is.lisp`.

</ul>




## [yes_macros.lisp](src/yes_macros.lisp)




<ul>

Tests for `macros.lisp`.

</ul>




## [yes_my.lisp](src/yes_my.lisp)




<ul>

Tests for `my.lisp`.

</ul>




## [yes_rows.lisp](src/yes_rows.lisp)




<ul>

Tests for  `rows.lisp`.

</ul>




## [yes_yes.lisp](src/yes_yes.lisp)




<ul>

Tests for the test engine `yes.lisp`.

</ul>


; os.lisp
