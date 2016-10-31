require 'nokogiri'
require 'open-uri'

link = "http://galleries.nascar.com/gallery/732/cubs-vs.-indians-and-long-nascar-droughts"



def scrape_image_data(url)

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

	picture_urls

end



def download_image(url, dest)
  open(url) do |u|
    File.open(dest, 'wb') { |f| f.write(u.read) }
  end
end



def scrape_description_data(url)

	the_raw_data = Nokogiri::HTML(open(url))

	the_scripts_data = the_raw_data.css('script')[-2].text.scan(/(?<=description": ).*?(?=","credit)/).flatten

	picture_descriptions = []

	the_scripts_data.each do |the_item|
		new_item = the_item.tr('"', '')
		clean_item = Nokogiri::HTML.parse(new_item).text.gsub!(/(<[^>]*>)|\n|\t/s) {""}
		picture_descriptions.push(clean_item)
	end

	final_descriptions = picture_descriptions.map do |the_description|
		the_description + "\n\n"
	end

	final_descriptions
end



# images = scrape_image_data(link)
the_text = scrape_description_data(link)
	
puts the_text

# images.each do |url|
# 	download_image(url, url.split('/').last)
# end