#!/usr/bin/ruby
#
# ansi2html
#
# Convert the ansi output from an xterm screen print
# into html.  Plus some hacky stuff specifically for
# editor.rb output.
#
# To get the screen print, run:
# xterm -xrm '*printerCommand: cat > /tmp/xterm_dump' -xrm '*printAttributes: 2'
#

file = ARGV[0]
if file
	f = File.open(file)
else
	f = STDIN
end

puts "<pre style=\"border: black 1px solid; display: inline-block\">"
f.each_line{|line|

	line.chomp!

	# remove weird starting character
	line = line.gsub(/\e#5/,'')

	# remove null color at start of line
	line = line.gsub(/^\e\[0m/,'')

	# process text decoration
	a = line.partition(/\e\[.*?m/)
	aline = a[0]
	while a[1] != ""
		cs = "color"
		a[1][2..-2].split(';').each{|code|
			case code
				when '0'
					aline += "<code style=\"color:black; background-color:white; text-decoration:none\">"
				when '7'
					#aline += "<code style=\"background-color:black\">"
					cs = "background-color"
				when '36'
					aline += "<code style=\"#{cs}:blue\">"
				when '34'
					aline += "<code style=\"#{cs}:cyan\">"
				when '33'
					aline += "<code style=\"#{cs}:orange\">"
				when '4'
					aline += "<code style=\"text-decoration:underline\">"
			end
		}
		a = a[2].partition(/\e\[.*?m/)
		aline += a[0]
	end

	n = aline.scan("<code").length
	puts aline + "</code>"*n
}
puts "</pre>"

f.close
