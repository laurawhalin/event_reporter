require_relative 'finder'

class Queue
  attr_reader :repository
  attr_accessor :results

  def initialize(repository = Finder.load_entries('./lib/'))
    @repository = repository
    @results = []
  end

  def lookup(method, string)
    if method == "first_name"
      results = repository.find_by_first_name(string)
    elsif method == "last_name"
      results = repository.find_by_last_name(string)
    elsif method == "city"
      results = repository.find_by_city(string)
    elsif method == "state"
      results = repository.find_by_state(string)
    end
  end

  def clear
    results = []
  end
end
