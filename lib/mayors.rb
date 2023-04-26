require 'nokogiri'   
require 'open-uri'
require 'pry'
require 'json'

#binding.pry

townhall_list_url = "https://annuaire-des-mairies.com/val-d-oise.html"

def get_townhall_list(townhall_list_url)
  
  urls = []
  emails = []
  towns = []

  # Get the HTML content of the townhall list page
  townhall_list_page = Nokogiri::HTML(URI.open(townhall_list_url))

  # Get the name of each town in the list
  townhall_list_page.css('a.lientxt').each do |link|
    towns << link.text
  end

  # Get the URL of each town in the list
  townhall_list_page.css('a.lientxt').each do |link|
    urls << "https://annuaire-des-mairies.com" + link['href'][1..-1] 
  end

  # Get the email address of each town
  urls.each do | url |
    email_list = Nokogiri::HTML(URI.open(url))  
    text = email_list.xpath('//tbody/tr[4]/td[2]').map(&:text)
    emails << text[0]
  end

  # Create a hash with the towns and their email addresses
  hash = towns.zip(emails).to_h

  # Generate JSON file
  File.open("townhall_list.json","w") do |f|
    f.write(hash.to_json)
  end

end





# Call the method with the URL of the townhall list page
get_townhall_list(townhall_list_url)

