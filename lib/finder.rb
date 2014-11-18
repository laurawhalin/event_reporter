require 'csv'
require_relative 'entry'

class Finder
  attr_reader :entries

  def self.load_entries(name =  'event_attendees.csv')
    file = File.join("./lib", name)
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

  def find_by_first_name(string)
    entries.select { |entry| entry.first_name.downcase == string.downcase }
  end

  def find_by_last_name(string)
    entries.select { |entry| entry.last_name.downcase == string.downcase }
  end

  def find_by_city(string)
    entries.select { |entry| entry.city == string.downcase }
  end

  def find_by_state(string)
    entries.select { |entry| entry.state == string }
  end

  def find_by_email_address(string)
    entries.select { |entry| entry.email_address == string }
  end

  def find_by_phone_number(string)
    entries.select { |entry| entry.phone_number == string }
  end

  def find_by_address(string)
    entries.select { |entry| entry.address == string }
  end

  def find_by_zip_code(string)
    entries.select { |entry| entry.zip_code == string }
  end
end
