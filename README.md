ansi2html
=========

This is a ruby script to convert ansi-escaped text to html.
The purpose is to display xterm screen prints in html.
This is an alternative to taking a screen shot.
I wrote it because it seemed silly to use image-based screenshots
for text-based output.

This is a quick script I wrote, and will probably not work in
many cases.


Installation
------------

No need to install: it is a self-contained ruby script.

If you want to work with ansi-escaped output from an xterm,
you must specify the following options to xterm

	*printerCommand: ruby <PATH>/ansi2html.rb > /tmp/xterm_dump.html
	*printAttributes: 2

If you don't want to set these globally, you can run:

	xterm -xrm '*printerCommand: ruby <PATH>/ansi2html.rb > /tmp/xterm_dump.html' -xrm '*printAttributes: 2'


Usage
-----

The script reads a single file from stdin or the command line
and writes html output to stdout.


Options
-------

The default colors are white background and black text.
The -d (--dark) option sets some light colors to be a little darker.
The -l (--light) option sets some lighter colors to be a little darker.
The -b (--background) options lets you set the background color to be
and valid html color specifier.
The -f (--foreground) option does the same for the default text color.


Example
-------

See http://wx13.com/code/ansi2html for an example.


License
-------

Copyright (C) 2011-2012, Jason P. DeVita (jason@wx13.com)

Copying and distribution of this file, with or without modification,
are permitted in any medium without royalty or restriction. This file
is offered as-is, without any warranty.
