# lib/spreadsheet.rb

require "google_drive"
require_relative "lib/mayors.rb"

session = GoogleDrive::Session.from_config("config.json")

def save_as_spreadsheet(file)

end