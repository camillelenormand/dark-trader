# lib/representatives.rb

require 'nokogiri'   
require 'open-uri'
require 'pry'

def get_representatives

  deputies = {}
  names = []
  i = 0
  total_pages = 20
  path = "https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&lang=fr&debut_deputes="
  first_names = []
  last_names = []
  emails = []

  # Loop through each page and display the items
  while i < total_pages do
    new_url = path+i.to_s+"#pagination_deputes"
    content = Nokogiri::HTML(URI.open(new_url))
    content.css('//*[@id="content"]/div/div/ul/li/h2').each do |link|
      names << link.text.strip
    end
    content.xpath('//a[contains(@href, "mailto")]').each do | email |
      emails << email.text.split(' ')
    end

    # Split firstnames and lastnames
    names.each do |name|
      split_name = name.split(' ')
      first_names << split_name[0]
      last_names << split_name[1]
    end
    i += 10
  end
  # Create hash
  deputies[:first_name] = first_names
  deputies[:last_name] = last_names
  deputies[:email] = emails
  
  deputies = deputies[:first_name].zip(deputies[:last_name], deputies[:email]).map {
    | first_name, last_name, email | {
        first_name: first_name,
        last_name: last_name,
        email: emails
    }
  }
puts deputies

end

get_representatives