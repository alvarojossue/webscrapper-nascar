class Gallery
	def initialize(url)
		@url = url
	end


	def scrape_image_data

		raw_data = Nokogiri::HTML(open(@url))

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
		valid_url = URI.parse(URI.encode(url.strip)) #Turn URLs with whitespaces into valid URLs
	  	open(valid_url) do |u|
	    	File.open(dest, 'wb') { |f| f.write(u.read) } #Create file and write content from URL
	  	end
	end



	def scrape_description_data

		description_number = 1
		the_raw_data = Nokogiri::HTML(open(@url))

		the_scripts_data = the_raw_data.css('script')[-2].text.scan(/(?<=description": ).*?(?=","credit)/).flatten

		picture_descriptions = []

		the_scripts_data.each do |the_item|
			new_item = the_item.tr('"', '')
			clean_item = Nokogiri::HTML.parse(new_item).text.gsub(/(<[^>]*>)|\n|\t/s) {""}
			picture_descriptions.push(clean_item)
		end

		final_descriptions = picture_descriptions.map do |the_description|
			text = description_number.to_s + " - " + the_description + "\n\n"
			description_number += 1
			text
		end

		final_descriptions
	end
end