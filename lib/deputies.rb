require 'nokogiri'   
require 'open-uri'
require 'pry'
require 'json'

def get_deputies

  deputies = []
  names = []
  i = 0
  total_pages = 70
  path = "https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&lang=fr&debut_deputes="
  first_names = []
  last_names = []
  emails = []

  # Loop through each page of the website
  while i < total_pages do
    new_url = path+i.to_s+"#pagination_deputes"
    puts new_url
    content = Nokogiri::HTML(URI.open(new_url))
    # Extract the names of the deputies
    content.css('//*[@id="content"]/div/div/ul/li/h2').each do |link|
      names << link.text.strip
    end
    # Extract the email addresses of the deputies
    content.xpath('//a[contains(@href, "@assemblee-nationale.fr")]').each do | email |
      emails << email.text.split(' ')
    end
    i += 10
  end

  # Split firstnames and lastnames
  names.each do |name|
    split_name = name.split(' ')
    first_names << split_name[0]
    last_names << split_name[1]
  end

  # Create a hash for each deputy and add it to the deputies array
  first_names.each_with_index do |first_name, index|
    deputy = {
      "first_name": first_name,
      "last_name": last_names[index],
      "email": emails[index]
    }

    deputies << deputy
  end

  # Create a JSON object with the deputies array and pretty print it
  json_object = {
    "deputies": deputies
  }

  puts JSON.pretty_generate(json_object)

end

# Call the get_representatives method to start the script
get_deputies
