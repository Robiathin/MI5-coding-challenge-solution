#!/usr/bin/env ruby

require "rmagick"

# Use RMagick to convert image to XPM format. This entire proccess could be
# done using just RMagick to get the data from the image, however, it was
# easier while trying to solve this to just iterate over XPM.
img = Magick::Image.read(ARGV[0]).first
img.write "xpm:/tmp/mi5"

# Read XPM file and clean format to only leave "." or " " characters. The
# resulting array will with have a string representing each line of the file.
# Sort of like: ["......   ", "  .......", ".       .."]
text = Array.new
File.read("/tmp/mi5").scan(/".*"/)[3..-1].each do |x|
	text.push x[1..-2]
end

# Create one continuous string from the array and group by character type.
# Like this: ["...", "      ", "....."]
text = text.join.scan /\.+|\s+/

# Get the length of each sequence of unique charachters and add them to a string.
# This will produce a dash seperate hexadecimal string, Ex: "f4-23-3e-5d". The size
# of each segment of characters represents the ASCII value for a character in the
# final message.
nums = ""
text.each { |x| nums << x.size }

# Remove the dashes from the hexadecimal string and convert it to ASCII, then print
# the result.
puts [nums.gsub("-", "")].pack "H*"

# The result is:
# Congratulations, you solved the puzzle! Why don't you apply to join our team? mi5.gov.uk/careers
