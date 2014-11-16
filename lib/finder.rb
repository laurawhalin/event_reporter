require 'csv'
require_relative 'entry'

class Finder
  attr_reader :entries
  def self.load_entries(directory)
    file = File.join(directory, 'event_attendees.csv')
    data = CSV.open(file, headers: true)
      data.foreach do |row|
        Entry.create( :first_name => row['first_Name'],
                      :last_name => row['last_Name'],
                      :email_address => row['Email_Address'],
                      :phone_number=> row['HomePhone'],
                      :address => row['Street'],
                      :city => row['City'],
                      :state => row['State'],
                      :zip_code => row['Zipcode']

                    )
      end
      rows = data.map do |row|
        Entry.new(row)
      end
    new(rows)
  end

  def initialize(entries)
   @entries = entries
  end

  def find_by_first_name(string)
    entries.select { |entry| entry.first_name == string }
  end

  def find_by_last_name(string)
    entries.select { |entry| entry.last_name == string }
  end

  def find_by_city(string)
    entries.select { |entry| entry.city == string }
  end

  def find_by_state(string)
    entries.select { |entry| entry.state == string }
  end
end
