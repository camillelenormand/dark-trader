# Importing the required libraries
require 'nokogiri'   
require 'open-uri'
require 'pry'
require 'json'

# Defining a function to get the representatives
def get_representatives

  # Initializing the variables
  deputies = []
  names = []
  i = 0
  total_pages = 200
  path = "https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&lang=fr&debut_deputes="
  first_names = []
  last_names = []
  emails = []

  # Loop through each page and display the items
  while i < total_pages do
    new_url = path+i.to_s+"#pagination_deputes"
    content = Nokogiri::HTML(URI.open(new_url))

    # Extracting the names of the representatives
    content.css('//*[@id="content"]/div/div/ul/li/h2').each do |link|
      names << link.text.strip
    end

    # Extracting the emails of the representatives
    content.xpath('//a[contains(@href, "mailto")]').each do | email |
      emails << email.text.split(' ')
    end

    # Splitting the firstnames and lastnames
    names.each do |name|
      split_name = name.split(' ')
      first_names << split_name[0]
      last_names << split_name[1]
    end
    i += 10
  end

  # Creating a hash of the deputies
  first_names.each_with_index do |first_name, index|
    deputy = {
      "first_name": first_name,
      "last_name": last_names[index],
      "email": emails[index]
    }

    deputies << deputy
  end

  # Creating a JSON object of the deputies
  json_object = {
    "deputies": deputies
  }

  # Printing the JSON object
  puts JSON.pretty_generate(json_object)

end

# Calling the function to get the representatives
get_representatives
