require 'csv'
require_relative 'entry'

class Finder
  attr_reader :entries

  def self.load_entries(directory)
    file = File.join(directory, 'event_attendees.csv')
    data = CSV.open(
          file,
          :headers => [ :entry,
                        :reg_date,
                        :first_name,
                        :last_name,
                        :email_address,
                        :phone_number,
                        :address,
                        :street,
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

  def find_by_first_name(string)
    entries.select { |entry| entry.first_name == string }
  end

end
