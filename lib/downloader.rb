class Downloader

	def initialize (array)
		@array = array
	end

	def download_image(name)
		picture_number = 1

		@array.each do |url|
			valid_url = URI.parse(URI.encode(url.strip)) #Turn URLs with whitespaces into valid URLs
			file_name = picture_number.to_s + "-" + name + ".jpg"

  			open(valid_url) do |u|
    			File.open(file_name, 'wb') { |f| f.write(u.read) } #Create file and write content from URL
  			end
  			picture_number += 1
		end
	end
	
end