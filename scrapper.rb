require 'nokogiri'
require 'open-uri'

url = "http://galleries.nascar.com/gallery/736/at-track-photos-sunday-martinsville"

data = Nokogiri::HTML(open(url))

puts data