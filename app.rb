require 'nokogiri'
require 'open-uri'

require_relative("lib/scrapper.rb")
require_relative("lib/downloader.rb")


#Instructions

puts "Scrapper for NASCAR Galleries\nPlease insert the URL of the gallery you want to scrape:"

link = gets.chomp

puts "How would you like to name the files?"

filename = gets.chomp

puts "Loading... Please wait\n.\n.\n.\n.\n.\n.\n."


#Scrapper

gallery = Gallery.new(link)

images = gallery.scrape_image_data
descriptions = gallery.scrape_description_data


#Downloader

downloader = Downloader.new(images)

downloader.download_image(filename)


puts descriptions