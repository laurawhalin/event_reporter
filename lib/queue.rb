require_relative 'finder'

class Queue
  attr_reader :repository

  def initialize(repository = Finder.load_entries('./lib/'))
    @repository = repository
    @results = []
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
    puts "LAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE\n"
    puts print_results
  end

  def print_by(attribute)

  end

  def print_results
    @results.each do |result|
      puts "#{result.last_name}\t#{result.first_name}\t#{result.email_address}"
    end
  end

  def save(file_name)
    
  end
end
