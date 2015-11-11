Bootify and Genquiz Installation
================================

Installation is very simple. You have three choices:

a) Don't install at all - just run the code from this directory

b) Add this directory to your path

c) Just place the .pl and .pm files somewhere in your path together
with the contents of the share directory. e.g.

    dest=$(HOME)/bin
    cp *.pl *.pm $dest
    mkdir -p $dest/share/bootify
    cp share/bootify/* $dest/share/bootify

This is done by the install.sh script

