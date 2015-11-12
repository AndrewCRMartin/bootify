Bootify and Genquiz Installation
================================

Installation is very simple. You have three choices:

a) Don't install at all - just run the code from this directory

b) Add this directory to your path

c) Just place the .pl and .pm files somewhere in your path together
with the contents of the share directory. e.g.

    dest=${HOME}/bin
    cp *.pl *.pm $dest
    mkdir -p $dest/share/bootify
    cp share/bootify/* $dest/share/bootify

This is done by the `install.sh` script

Setup
-----

You need to ensure that the web directory you use is set up to allow
`ExecCGI` and treats scripts with the extension `.cgi` as CGI
scripts. Alternatively, this directory must allow all options to be
overridden since a `.htaccess` file will be created in the directory
that sets these options.

Example
-------

Assuming your web directory is `/var/www/html/test/bootify/', do the following:

    cd /var/www/html/test/bootify
    bootify.pl ~/git/bootify/test/test.in



    