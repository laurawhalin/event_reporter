gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/queue'
#require_relative '../lib/finder'

class QueueTest < Minitest::Test
  def test_the_queue_is_empty_at_first
    queue = Queue.new
    assert_equal 0, queue.results.count
  end

  def test_it_finds_by_first_name
    repository = Minitest::Mock.new
    queue = Queue.new(repository)
    repository.expect(:find_by_first_name, [], ["Smith"])
    queue.lookup("first_name", "Smith")
    repository.verify
  end

  def test_it_finds_by_last_name
    repository = Minitest::Mock.new
    queue = Queue.new(repository)
    repository.expect(:find_by_last_name, [], ["Taylor"])
    queue.lookup("last_name", 'Taylor')
    repository.verify
  end

  def test_it_finds_by_city
    repository = Minitest::Mock.new
    queue = Queue.new(repository)
    repository.expect(:find_by_city, [], ["Denver"])
    queue.lookup("city", 'Denver')
    repository.verify
  end

  def test_it_finds_by_state
    repository = Minitest::Mock.new
    queue = Queue.new(repository)
    repository.expect(:find_by_state, [], ["CO"])
    queue.lookup("state", 'CO')
    repository.verify
  end

  def test_queue_contains_one_after_searching_by_first_name
    queue = Queue.new
    assert_equal 78, queue.lookup("first_name", "Sarah").count
  end

  def test_queue_zeros_out_after_clearing
    queue = Queue.new
    assert_equal 78, queue.lookup("first_name", "Sarah").count
    queue.clear
    assert_equal 0, queue.results.count
  end

end
