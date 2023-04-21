# lib/cryptos.rb

require 'nokogiri'   
require 'open-uri'
require 'pry'

def crypto_scrapper
  # Call url
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))  
  # Search for nodes by xpath and return only text 
  all_names = page.xpath('//div[@class="sc-22e34915-0 jlJKxd cmc-table__column-name cmc-table__column-name--narrow-layout"]/a[@class="cmc-table__column-name--symbol cmc-link"]').map(&:text)
  all_prices = page.xpath('//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price"]/div[@class="sc-cadad039-0 clgqXO"]/a[@class="cmc-link"]/span').map(&:text)

  # Combine the two arrays into a hash
  hash = all_names.zip(all_prices).to_h

  binding.pry

end

# Call the method
puts crypto_scrapper
