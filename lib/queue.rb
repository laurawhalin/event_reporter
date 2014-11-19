require_relative 'finder'
require_relative 'messages'
require 'csv'

class Queue
  attr_reader :repository, :messages

  def initialize(repository = Finder.load_entries)
    @repository = repository
    @results = []
    @messages = Messages.new
  end

  def lookup(attribute, string)
    case attribute
    when "first_name" then @results = repository.find_by(attribute, string)
    when "last_name"  then @results = repository.find_by(attribute, string)
    when "city"       then @results = repository.find_by(attribute, string)
    when "state"      then @results = repository.find_by(attribute, string)
    end
  end

  def clear
    @results = []
  end

  def count
    @results.count
  end

  def print_results
    @results.map do |result|
      messages.print_formatted_queue_results(result)
    end
  end

  def sort_by(attribute)
    @results.sort_by! do |result|
      result.send(attribute)
    end
  end

  def print_by(attribute)
    sort_by(attribute)
    @results.map do |result|
      messages.print_formatted_queue_results(result)
    end
  end

  def save(file_name)
    file = File.open("./data/#{file_name}", "w+") do |file|
      file << messages.header
      @results.map do |result|
        file << [result.last_name, result.first_name, result.email_address, result.zip_code, result.city, result.state, result.address, result.phone_number].join(", ") + "\n"
      end
    end
  end
end
