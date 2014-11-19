require_relative '../test_helper'
require_relative '../lib/queue'

class QueueTest < Minitest::Test
  def test_the_queue_is_empty_at_first
    queue = Queue.new
    assert_equal 0, queue.count
  end

  def test_it_finds_by_first_name
    repository = Minitest::Mock.new
    queue = Queue.new(repository)
    repository.expect(:find_by, [], ["first_name", "Smith"])
    queue.lookup("first_name", "Smith")
    repository.verify
  end

  def test_it_finds_by_last_name
    repository = Minitest::Mock.new
    queue = Queue.new(repository)
    repository.expect(:find_by, [], ["last_name", "Taylor"])
    queue.lookup("last_name", 'Taylor')
    repository.verify
  end

  def test_it_finds_by_city
    repository = Minitest::Mock.new
    queue = Queue.new(repository)
    repository.expect(:find_by, [], ["city", "Denver"])
    queue.lookup("city", 'Denver')
    repository.verify
  end

  def test_it_finds_by_state
    repository = Minitest::Mock.new
    queue = Queue.new(repository)
    repository.expect(:find_by, [], ["state", "CO"])
    queue.lookup("state", 'CO')
    repository.verify
  end

  def test_queue_contains_one_after_searching_by_first_name
    queue = Queue.new
    assert_equal 78, queue.lookup("first_name", "sarah").count
  end

  def test_queue_zeros_out_after_clearing
    queue = Queue.new
    assert_equal 78, queue.lookup("first_name", "sarah").count
    queue.clear
    assert_equal 0, queue.count
  end

  def test_returns_queue_count
    queue = Queue.new
    queue.lookup("first_name", "sarah")
    assert_equal 78, queue.count
  end

  def test_it_finds_two_word_first_names
    queue = Queue.new
    queue.lookup("first_name", "summer rayne")
    assert_equal 1, queue.count
  end

  def test_it_prints_the_results_of_the_queue
    queue = Queue.new
    print_result =
      ["Riordan		Sarah		ctuhspugha@jumpstartlab.com		80212		Denver		CO		2814 Tennyson St.		7202058000",
      "Jenkins		Alexis		sqcoomer11@jumpstartlab.com		80212		Denver		CO		5020 W. Moncrieff Pl		9285563000",
      "Joyce		Addison		oxke.connery@jumpstartlab.com		80222		Denver		CO		1540 S. Bellaire St		7088299000"]
    queue.lookup("city", "denver")
    assert_equal print_result, queue.print_results
  end

  def test_it_creates_a_csv
    queue = Queue.new
    queue.lookup("first_name", "tom")
    queue.save("myfile.csv")
    expected_csv = "swider,tom,srooddel@jumpstartlab.com,55057,northfield,mn,300 north college street,9184414000\n"
    actual_csv = IO.readlines("./data/myfile.csv")[3]
    assert_equal(expected_csv, actual_csv)
  end
end
