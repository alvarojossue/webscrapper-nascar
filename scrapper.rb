require 'nokogiri'
require 'open-uri'

url = "http://galleries.nascar.com/gallery/736/at-track-photos-sunday-martinsville"

raw_data = Nokogiri::HTML(open(url))

scripts_data = raw_data.css('script')[-2].text.split(',') #Second to last script item, which includes picture urls

picture_urls = []

scripts_data.each do |item| #Gets url for big pictures only
	if item.include?('"big": ')
		new_item = item.split('"big": ')
		new_item.each do |element|
			if element.include?('http')
				clean_element = element.tr('"', '')
				picture_urls.push(clean_element)
			end
		end
	end
end

puts picture_urls

