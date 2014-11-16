require_relative 'finder'

class Queue
  attr_reader :repository

  def initialize(repository = Finder.load_entries('./lib/'))
    @repository = repository
    @entries = []
  end

  def lookup(name)
    repository.find_by_first_name(name)
  end
end

queue = Queue.new
puts queue.lookup("Sarah")
