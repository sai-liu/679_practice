# homework 1: shell tools and regular expressions

## background (may be skipped)

SNaQ is a method to estimate the phylogenetic (~ genealogical) networks.
Given input data, SNaQ seeks the network that minimizes a **score**
(negative log pseudo-likelihood).
This score has a rough surface, often with local minima,
and the space of networks is a complex space to explore.
Therefore, each SNaQ analysis does **multiple runs**,
then returns the best network across all the runs.

Several SNaQ analyses were performed, always on the same input data,
with varying values of tuning parameters. These parameters control
how the search is done and when it is stopped. The goal of this study
was to find a combination of tuning parameters that makes the analyses
faster but almost as accurate, compared to the default parameters.

In this assignment, you will perform data cleaning tasks.
In homework 1.1, you will clean data file names. In homework 1.2 and 1.3,
you will extract relevant information from paired `out` and `log` files,
and organize this information in a new clean table.

## data files

For each analysis, 2 files were created:
`xxx.out` in the directory `out` (main output file)
and `xxx.log` in the directory `log` (to record the parameter values and
details on the individual runs of a single analysis).
Here, `xxx` is an arbitrary name chosen by the analyst.

## homework 1.1

learning goals:
- write a shell script that includes a loop
- provide instructions to reproduce the process

### task

Create a shell script `normalizeFileNames.sh` to change all file names
`timetesty_snaq.log` to `timetest0y_snaq.log`,
where "y" is a digit between 1 and 9.
For example, your script should change the name of file
`log/timetest3_snaq.log` to `log/timetest03_snaq.log`.
But it should preserve the name of file `log/timetest13_snaq.log`.
(The desired outcome is to have `timetest03_snaq.log` appear
before `timetest13_snaq.log` when sorted alphabetically, for example.)
Note that the files need to be *renamed*.
After running your script, the `log/` folder should not contain any
file named `log/timetest3_snaq.log`, for example.
These old names should be gone.

Similarly, your script should change
`timetesty_snaq.out` to `timetest0y_snaq.out` inside the `out/` folder.

### tag the current version of your project and submit

When you are done, follow these
[instructions](https://github.com/UWMadison-computingtools-master/general-info#submit-your-assignment)
to submit your assignment.
Make sure that you create a tag named `v1.1`
(to mean version 1.1, for homework 1.1).

## homework 1.2

Before starting your work for this exercise,
**get any update** that the instructor or TA might have made to your repository
by pulling them from your github repository into your local repository.
Just do `git pull` for this.

### task

Create a shell script `summarizeSNaQres.sh` to start a summary of the results
from all these analyses. The script should produce a table in `csv` format,
with 1 row per analysis and 3 columns:

- "analysis": the file name root ("xxx")
- "h": the maximum number of hybridizations allowed during the analysis: `hmax`
- "CPUtime": total CPU time, or "Elapsed time".

### requirements and details

learning goals: get practice with basic shell commands,
`for` loops, and regular expressions.

For this exercise, use **only** the commands we have seen so far:
like `head`, `echo`, pipes, redirection, regular expressions,
and `grep` to search for things.
Otherwise, you would miss the goal of the current exercise.  
Do **not** used tools like `sed`, `basename` and/or `dirname`:
homework 1.3 below will provide practice with these other tools.  
Do **not** use tools like R, Python, Julia or `bc`:
otherwise, you would be missing on a major goal of the exercise,
which is to use regular expressions and shell scripting
(and your grade would be affected).

Hint: start by finding one or a set of commands to work with a single
analysis, like the analysis whose results are in `log/bT1.log`
and `out/bT1.out`:

- find a command to extract the "root" name of this analysis (`bt1` here),
  and to capture it in a variable.
- find a single command to extract one piece only (like h), again just
  for this `bt1` analysis.
- find another command to extract the CPU time for that analysis.

Once you have commands that work on a single analysis
(to extract info from a single pair of files: log and out), then wrap these up
into loop, in a script, to apply this to all analyses/files.

requirements about output:

- have the 3 columns in the exact order and with the exact column names
  as specified above (a script will be used to check that the output is
  as expected)
- use csv format correctly: commas `,` to separate values (columns),
  no spaces around commas,
  no comma at the end after the last value on each row,
  no comments. For example, the first line should contain this exactly:
  `analysis,h,CPUtime`

### tag and submit

When you are done,
[submit](https://github.com/UWMadison-computingtools-master/general-info#submit-your-assignment)
your assignment like you did for homework 1.1,
but create a tag named `v1.2` (to mean version 1.2, for homework 1.2) this time.
Before tagging & submitting, make sure to look at your repository
on github in a browser, to check that everything is where it should be
and that there are no errors in your markdown syntax.


## homework 1.3

Before starting your work for this exercise, do `git pull` to
get any potential update that the instructor or TA might have made
to your repository, from your github repo into your local repo.

### task

Modify your script `summarizeSNaQres.sh` that summarizes the results,
to add more information. You may comment out parts of your script that
you no longer need (use `#` for comments), or you can delete these parts
altogether, because you can always go back to them using git anyway
(check your tag on github for instance).

The script should still produce a table in `csv` format
with 1 row per analysis,
the same columns as before and additional columns:

- analysis: file name root ("xxx"), like in homework 1.2
- h: the maximum number of hybridizations allowed during the analysis: `hmax`
- CPUtime: total CPU time, or "Elapsed time"
- Nruns: number of runs
- Nfail: tuning parameter, "max number of failed proposals"
- fabs: tuning parameter called "ftolAbs" in the log file (tolerated
  difference in the absolute value of the score function, to stop the search)
- frel: "ftolRel"
- xabs: "xtolAbs"
- xrel: "xtolRel"
- seed: main seed, i.e. seed for the first runs
- under3450: number of runs that returned a network with a score
  (`-loglik` value) better than (below) 3450

### requirements and details

The learning **goal** of this exercise is to get practice writing
a shell script, using shell loops and test statements (for, if/then),
using regular expression and text search & replace tools.

requirements about coding:

- this time, **use `sed`** at least once,
  and any other shell command seen earlier
- also **use `basename`** and/or `dirname`
- use **at least one `if`** statement
- have at least one `for` loop (like for homework 1.2)
- again, do *not* use R or Python or Julia:
  the goal here is to learn shell scripting
- do *not* use the basic calculator `bc`:
  a major goal of the exercise is to use regular expressions.
  Using `bc` or a coding language other than the shell would just
  miss the point of the exercise (and your grade would be affected).

Hint: all -loglik values are over 3430, as the output of this command shows:
`grep -oh "loglik [0-9]*\." out/*.out | sort `.
You can modify this command to capture only the values under 3450
(because they should start with 343 or 344), and from a single analysis only.
Then pipe your modified command to some other command to count how many times
such values (under 3450) were found, in a given analysis file.

requirements about output:

- have the columns in the exact order and with the exact column names
  as specified above (a script will be used to check that the output is
  as expected)
- correct csv format: commas `,` to separate values (columns),
  no spaces around commas,
  no comma at the end after the last value on each row,
  no comments

requirements about documentation:

Make sure to put a comment near each command that uses a regular expression
(like `sed`), to explain what your command is meant to do.
This is to make your code human-readable.
Regular expressions are notoriously hard to read.

Also modify the [readme.md](readme.md) file to indicate what
scripts were run, when, from which directory,
and where the output was created.

### tag and submit

Again,
[submit](https://github.com/UWMadison-computingtools-master/general-info#submit-your-assignment)
your assignment, this time using tag `v1.3`,
and check your repo on github before tagging & submitting.
