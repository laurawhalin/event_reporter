require_relative 'finder'

class Queue
  attr_reader :repository, :entries

  def initialize(repository = Finder.load_entries('./lib/'))
    @repository = repository
    @entries = []
  end

  def lookup(method, string)
    if method == "first_name"
      entries << repository.find_by_first_name(string)
    elsif method == "last_name"
      repository.find_by_last_name(string)
    elsif method == "city"
      repository.find_by_city(string)
    elsif method == "state"
      repository.find_by_state(string)
    end
  end
end

queue = Queue.new
puts queue.lookup("first_name", "Sarah")
