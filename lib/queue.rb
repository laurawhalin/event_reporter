require_relative 'finder'    # => true
require_relative 'messages'  # => true
require 'pry'                # => true

class Queue
  attr_reader :repository, :messages  # => nil

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

  def print_queue
    print_results
  end

  def print_by(attribute)

  end


  def print_results
    @results.map do |result|
      "#{result.last_name}\t #{result.first_name}\t"
    end
  end

  def save(file_name)

  end
end
