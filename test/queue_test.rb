gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/queue'
#finish testing all other lookup methods

class QueueTest < Minitest::Test
  def test_the_queue_is_empty_at_first
    queue = Queue.new
    assert_equal 0, queue.count
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
    assert_equal 0, queue.count
  end

  def test_returns_queue_count
    queue = Queue.new
    queue.lookup("first_name", "Sarah")
    assert_equal 78, queue.count
  end

  def test_it_finds_two_word_first_names
    skip
    queue = Queue.new
    queue.lookup("first_name", "Summer Rayne")
    assert_equal 1, queue.count
  end

  def test_it_prints_the_results_of_the_queue
    skip
    queue = Queue.new
    print_result =
      "LAST NAME	FIRST NAME	EMAIL	ZIPCODE	CITY	STATE	ADDRESS	PHONE
      Browne	Mary	arnfe015@jumpstartlab.com
      Campbell	Mary	lcanhook@jumpstartlab.com
      Joyce	Mary	fseff07438@jumpstartlab.com
      Schuster	Mary	eoiyu.xu@jumpstartlab.com
      Grant	Mary	ogtedtle@jumpstartlab.com
      Jolly	Mary	fxmasterson@jumpstartlab.com
      Corrado	Mary	rcblanton@jumpstartlab.com
      Ther	Mary	hobdul27@jumpstartlab.com
      Coomer	Mary	oered.schor@jumpstartlab.com
      Bell	Mary	cfeckerp@jumpstartlab.com
      Skaggs	Mary	ijlldurrett@jumpstartlab.com
      Shpino	Mary	nrr11388@jumpstartlab.com
      Costantini	Mary	hvoe13@jumpstartlab.com
      Bastias	Mary	gorench@jumpstartlab.com
      Gray	Mary	fuushma1@jumpstartlab.com
      Rodgers	Mary	ecbdulwa@jumpstartlab.com"
    queue.lookup("first_name", "Mary")
    assert_equal print_result, queue.print_queue
  end

  def test_it_prints_by_attribute_when_argument_is_passed_in

  end

end
