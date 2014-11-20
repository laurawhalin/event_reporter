require 'csv'
require_relative 'entry'

class Finder
  attr_reader :entries

  def self.load_entries(name = 'event_attendees.csv')
    file = File.join("./data", name)
      data = CSV.open(file, headers: true, :header_converters => :symbol.downcase)
      rows = data.map do |row|
        Entry.new(row)
      end
      new(rows)
  end

  def initialize(entries)
   @entries = entries
  end

  def find_by(criteria, attribute)
    entries.select { |entry| entry.send(criteria) == attribute }
  end

  def find_by_two(first_search, second_search)
    first_pass = entries.select { |entry| entry.send(first_search[0]) == first_search[1] }
    first_pass.select { |entry| entry.send(second_search[0]) == second_search[1] }
  end
end
