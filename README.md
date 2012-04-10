# Space [![Build Status](https://secure.travis-ci.org/svenfuchs/space.png?branch=master)](http://travis-ci.org/svenfuchs/space)

Here's a screenshot of my setup (iterm, tmux, vim, space) for working on
[travis](http://github.com/travis-ci).

![tmux based travis workspace](http://img.skitch.com/20120410-d4qk8ce75h6x7i7g7i2cbtjnn8.png)

The thing on the right side is an iterm split pane running space. The main
screen is take by a tmux session that has a vim and a zsh pane. (I use an iterm
pane for space so that I can switch between tmux windows but keep the space
view.)

The space view gives an overview of:

* current branch
* current commit
* bundler local flag
* git status (clean, dirty, ahead)
* bundle status (`bundle check`)
* dependencies

One can easily see that:

* repos 1-5 are using the bundler local flag, while 6-7 are using remote
  references
* repos 4, 6, 7 have dirty working directories
* repo 6 is 1 commit ahead of origin
* the bundle in repo 7 is not installed

Space checks for each dependency listed in a repo's Gemfile if the bundle is
locked to the hash that is currently checked out locally and display that
status information.

Also note that the repo numbers are referring to the tmux windows where
possible.

This screencast is from a very early version but still mostly valid. It also
demonstrates how screen can be used to run commands on multiple repositories at
once:

[![screencast](http://img.skitch.com/20120410-gyiprdiy8jyhwwp3pd4gafk3tu.png)](www.youtube.com/watch?v=NfYZysobsYo)

This is what the `~/.space/travis.yml` file for this setup looks like:

    base_dir: ~/Development/projects/travis
    repositories:
      - travis-ci
      - travis-hub
      - travis-listener
      - travis-core
      - travis-support
      - travis-worker
      - travis-build


