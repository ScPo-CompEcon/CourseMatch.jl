# CourseMatch

[![Build Status](https://travis-ci.com/floswald/CourseMatch.jl.svg?branch=master)](https://travis-ci.com/floswald/CourseMatch.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/floswald/CourseMatch.jl?svg=true)](https://ci.appveyor.com/project/floswald/CourseMatch-jl)
[![Codecov](https://codecov.io/gh/floswald/CourseMatch.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/floswald/CourseMatch.jl)


This is the repo for the `CourseMatch` term project of our course.

## Checklist

- [x] implement a `Student` struct to carry all relevant information
- [ ] implement `student`'s demand function: given prices, preferences and constraints, which is the optimal choice of courses
- [ ] test demand function
- [x] translate pseudo code of main price search algo from paper (algo 1)
- [ ] test pseudo code translation
- [ ] implement algo 2: refinement of price vector
- [x] implement neighboring price vector function
- [ ] test neighboring price vector function 

## Modus Operandi

* Please **never** push anything onto the `master` branch.
* Please **always** submit a pull request instead.

So:

1. step one should be for everyone to **fork** this repo to your github account. This will create a new repo on your account at `https://github.com/YOUR_GITHUB_USER/CourseMatch.jl.git`. Notice that you have to replace `YOUR_GITHUB_USER` with your github username
1. step two should be for everyone to get the code from their fork into their computer to start developing it. type `]` to activate your package manager. then:
    ```julia
    dev https://github.com/YOUR_GITHUB_USER/CourseMatch.jl.git   
    ```
    This will clone this repository to your computer at location `~/.julia/dev/CourseMatch`. Remember that your `~/.julia` can be seen by typing `DEPOT_PATH[1]` into your REPL.
1. You can now use the code in the package. In particular your should do in your REPL
    ```julia
    ]   # turn on Pkg mode
    activate CourseMatch   # activate pkg manager for this project
    instantiate   # download all required packages
    precompile    # precompile all
    test          # run the test suite of CourseMatch
    activate      # go back to main env (notice no arg given!)
    ```
1. If that works, exit pkg mode by hitting `Ctrl-c`. Let's see if the package also works in the main environment now.
1. Type `using CourseMatch` in the julia REPL (no longer in Pkg mode!)
1. Type `CourseMatch.VERSION`. you should see the current version.

## How to Make Changes and Contribute

1. Change the code on your computer in  `~/.julia/dev/CourseMatch` in your text editor / juno.
2. Notice that if you set up `Revise.jl` in your [`startup.jl` file as demonstrated](https://lectures.quantecon.org/jl/tools_editors.html#jl-startup-file), you can change the code in your editor, and your REPL will immediately reflect those changes (no manual reloading of the module needed!)
3. Once you are happy with your work, create a new git *branch* in the `~/.julia/dev/CourseMatch` folder. This is a live git repo.
4. For example
    ```bash
    cd ~/.julia/dev/CourseMatch
    git branch my_new_feature
    git checkout my_new_feature
    git add .    # this would add everything in current dir to your commit. alternatively give file names/paths
    git commit -m 'I added a new feature'  # message
    git push origin my_new_feature   # push your work to your fork on github
    ```
5. Finally, go to your fork at `https://github.com/YOUR_GITHUB_USER/CourseMatch.jl` and click on "new pull request" to create a new PR on the origin repo. 

## Style Guide

1. Indent by 4 whitespaces
2. DOCUMENT EACH FUNCTION like here: https://docs.julialang.org/en/v1/manual/documentation/
