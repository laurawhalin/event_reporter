require 'csv'
require_relative 'entry'

class Finder
  attr_reader :entries

  def self.load_entries(name =  'event_attendees.csv')
    file = File.join("./data", name)
    data = CSV.open(
          file,
          :headers => [ :entry,
                        :reg_date,
                        :first_name,
                        :last_name,
                        :email_address,
                        :phone_number,
                        :address,
                        :city,
                        :state,
                        :zip_code]
      )

    rows = data.map do |row|
      Entry.new(row)
    end
    new(rows)
  end

  def initialize(entries)
   @entries = entries
  end

  def find_by(attribute, string)
    entries.select { |entry| entry.send(attribute) == string }
  end
end
