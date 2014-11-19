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

  def lookup(method, string)
    if method == "first_name"
      @results = repository.find_by_first_name(string)
    elsif method == "last_name"
      @results = repository.find_by_last_name(string)
    elsif method == "city"
      @results = repository.find_by_city(string)
    elsif method == "state"
      @results = repository.find_by_state(string)
    end
  end

  def clear
    @results = []
  end

  def count
    @results.count
  end

  # def print_by(attribute)
  #   print_results.sort_by { |a| [a.attribute]}
  #   #need an output: puts "#{messages.header} + #{print_by(?)}" ??
  # end

  def titlize(attribute)
    words = attribute.split(' ')
    if words[1] == nil
      attribute.capitalize
    else
      words.map! do |word|
        word.capitalize
      end
      words.join(" ")
    end
  end

  def print_results
    @results.map do |result|
      "#{titlize(result.last_name)}\t\t#{titlize(result.first_name)}\t\t#{result.email_address}\t\t#{result.zip_code}\t\t#{titlize(result.city)}\t\t#{result.state.upcase}\t\t#{titlize(result.address)}\t\t#{result.phone_number}"
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
      "#{titlize(result.last_name)}\t\t#{titlize(result.first_name)}\t\t#{result.email_address}\t\t#{result.zip_code}\t\t#{titlize(result.city)}\t\t#{result.state.upcase}\t\t#{titlize(result.address)}\t\t#{result.phone_number}"
    end
  end

  def save(file_name)
    file = File.open("./data/#{file_name}", "w+") do |file|
      @results.map do |r|
        file << [r.last_name, r.first_name, r.email_address, r.zip_code, r.city, r.state, r.address, r.phone_number].join(", ") + "\n"
      end
    end
  end
end
