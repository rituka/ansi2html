#!/usr/bin/ruby
#
# ansi2html
#
# Convert the ansi output from an xterm screen print
# into html.
#
# To get the screen print, run:
# xterm -xrm '*printerCommand: ruby <PATH>/ansi2html.rb > temp.html' -xrm '*printAttributes: 2'
#
# Copyright (C) 2011-2012, Jason P. DeVita (jason@wx13.com)
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty or restriction.
# This file is offered as-is, without any warranty.

require 'optparse'

# default colors
$white = "#fff"
$black = "#000"
$blue = "#00f"
$cyan = "#0ff"
$yellow = "#ff0"
$green = "#0f0"
$magenta = "#f0f"
$red = "#f00"
$foreground = $black
$background = $white


# process options
optparse = OptionParser.new{|opts|
	opts.banner = "Usage: ansi2html [options] file"
	opts.on('-h','--help', 'Display options'){
		puts opts
		exit
	}
	opts.on('-d','--dark','Use a darker color versions'){
		$cyan = "#0aa"
		$yellow = "#aa0"
		$magenta = "#a0a"
	}
	opts.on('-l','--light','Use a lighter color versions'){
		$blue = "#66f"
		$green = "#6f6"
	}
	opts.on('-b','--background COLOR','Set background color'){|color|
		$background = color
	}
	opts.on('-f','--foreground COLOR','Set foreground color'){|color|
		$foreground = color
	}
}
optparse.parse!


# File or stdin?
file = ARGV[0]
if file
	f = File.open(file)
else
	f = STDIN
end

# process the text
puts "<pre style=\"border: black 1px solid; display: inline-block; background-color: #{$background}\">"
f.each_line{|line|

	line.chomp!

	# remove weird starting character
	line = line.gsub(/\e#5/,'')

	# process text color/decoration
	a = line.partition(/\e\[.*?m/)  # split at first escape
	aline = a[0]
	while a[1] != ""

		# if reverse gets set, then color turns to background-color
		cs = "color"

		# interpret each numerical code
		a[1][2..-2].split(';').each{|code|
			case code
				when '0'
					aline += "<code style=\"color:#{$foreground}; background-color:#{$background}; text-decoration:none\">"
				when '7'
					cs = "background-color"
				when '36'
					aline += "<code style=\"#{cs}:#{$cyan}\">"
				when '34'
					aline += "<code style=\"#{cs}:#{$blue}\">"
				when '33'
					aline += "<code style=\"#{cs}:#{$yellow}\">"
				when '31'
					aline += "<code style=\"#{cs}:#{$red}\">"
				when '32'
					aline += "<code style=\"#{cs}:#{$green}\">"
				when '35'
					aline += "<code style=\"#{cs}:#{$magenta}\">"
				when '4'
					aline += "<code style=\"text-decoration:underline\">"
				when '3'
					aline += "<code style=\"text-decoration:blink\">"
			end
		}
		a = a[2].partition(/\e\[.*?m/)
		aline += a[0]
	end

	# close tags
	n = aline.scan("<code").length
	puts aline + "</code>"*n
}
puts "</pre>"

f.close
