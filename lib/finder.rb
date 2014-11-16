require 'csv'
require_relative 'entry'
require 'pry'
binding.pry

class Finder
  def

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

end
