require 'nokogiri'
require 'open-uri'

url = "http://galleries.nascar.com/gallery/736/at-track-photos-sunday-martinsville"

raw_data = Nokogiri::HTML(open(url))

scripts_data = raw_data.css('script')[-2].text.split(',') #Second to last script item, which includes picture urls

picture_data = []

scripts_data.each do |item|
	if item.include?('big_thumbnail') && item.include?('"big":')
		picture_data.push(item)
	end
end

puts picture_data
