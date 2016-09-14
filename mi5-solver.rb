#!/usr/bin/env ruby

require 'rmagick'

img = Magick::Image.read(ARGV[0]).first
img.write "xpm:/tmp/mi5"
text = Array.new
File.read("/tmp/mi5").scan(/".*"/)[3..-1].each { |x| text.push x[1..-2] }
text = text.join.scan /\.+|\s+/
nums = ""
text.each { |x| nums << x.size }
puts [nums.gsub("-", "")].pack 'H*'
