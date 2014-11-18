require_relative 'finder'
require_relative 'messages'

class Queue
  attr_reader :repository, :messages

  def initialize(repository = Finder.load_entries('./lib/'))
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

  def print_queue
    puts messages.header
    puts print_results
  end

  def print_by(attribute)

  end

  def print_rows
    @rows.each do |row|
      puts row.join("\t")
    end
  end

  def print_results
    @rows = Array.new

    @results.each do |result|
      @rows << [result.last_name, result.first_name, result.email_address]
    end

    @rows.reduce(&:print_rows)
  end

  def save(file_name)

  end
end
