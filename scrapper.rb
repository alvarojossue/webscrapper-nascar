require 'nokogiri'
require 'open-uri'

url = "http://galleries.nascar.com/gallery/732/cubs-vs.-indians-and-long-nascar-droughts"

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

def download_image(url, dest)
  open(url) do |u|
    File.open(dest, 'wb') { |f| f.write(u.read) }
  end
end


picture_urls.each do |url|
	download_image(url, url.split('/').last)
end