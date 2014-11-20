require_relative '../test_helper'
require_relative '../lib/queue'
require_relative '../lib/messages'

class QueueTest < Minitest::Test
  def test_the_queue_is_empty_at_first
    queue = Queue.new
    assert_equal 0, queue.count
  end

  def test_the_repository_is_nil_without_loading
    queue = Queue.new
    refute queue.repository
  end

  def test_it_finds_by_first_name
    queue = Queue.new
    queue.repository = Minitest::Mock.new
    queue.repository.expect(:!=, [true], [nil])
    queue.repository.expect(:find_by, [], ["first_name", "smith"])
    queue.lookup("first_name", "smith")
    queue.repository.verify

    queue = Queue.new
    queue.repository = Finder.load_entries('event_attendees.csv')
    queue.lookup("first_name", "john")
    assert_equal 63, queue.count
  end

  def test_it_finds_by_last_name
    queue = Queue.new
    queue.repository = Minitest::Mock.new
    queue.repository.expect(:!=, [true], [nil])
    queue.repository.expect(:find_by, [], ["last_name", "white"])
    queue.lookup("last_name", "white")
    queue.repository.verify

    queue = Queue.new
    queue.repository = Finder.load_entries('event_attendees.csv')
    queue.lookup("last_name", "white")
    assert_equal 12, queue.count
  end

  def test_it_finds_by_city
    queue = Queue.new
    queue.repository = Minitest::Mock.new
    queue.repository.expect(:!=, [true], [nil])
    queue.repository.expect(:find_by, [], ["city", "denver"])
    queue.lookup("city", "denver")
    queue.repository.verify

    queue = Queue.new
    queue.repository = Finder.load_entries('event_attendees.csv')
    queue.lookup("city", "denver")
    assert_equal 3, queue.count
  end

  def test_it_finds_by_state
    queue = Queue.new
    queue.repository = Minitest::Mock.new
    queue.repository.expect(:!=, [true], [nil])
    queue.repository.expect(:find_by, [], ["state", "co"])
    queue.lookup("state", "co")
    queue.repository.verify

    queue = Queue.new
    queue.repository = Finder.load_entries('event_attendees.csv')
    queue.lookup("state", "co")
    assert_equal 29, queue.count
  end

  def test_queue_contains_one_after_searching_by_first_name
    queue = Queue.new
    queue.repository = Finder.load_entries
    assert_equal 78, queue.lookup("first_name", "sarah").count
  end

  def test_queue_zeros_out_after_clearing
    queue = Queue.new
    queue.repository = Finder.load_entries
    assert_equal 78, queue.lookup("first_name", "sarah").count
    queue.clear
    assert_equal 0, queue.count
  end

  def test_returns_queue_count
    queue = Queue.new
    queue.repository = Finder.load_entries
    queue.lookup("first_name", "sarah")
    assert_equal 78, queue.count
  end

  def test_it_finds_two_word_first_names
    queue = Queue.new
    queue.repository = Finder.load_entries
    queue.lookup("first_name", "summer rayne")
    assert_equal 1, queue.count
  end

  def test_it_can_find_by_two_attributes
    queue = Queue.new
    first_search = ["state", "co"]
    second_search = ["city", "denver"]
    queue.repository = Minitest::Mock.new
    queue.repository.expect(:!=, [true], [nil])
    queue.repository.expect(:find_by_two, [], [first_search, second_search])
    queue.lookup_multiple(first_search, second_search)
    queue.repository.verify

    queue = Queue.new
    queue.repository = Finder.load_entries
    first_search = ["first_name", "sarah"]
    second_search = ["state", "ca"]
    queue.lookup_multiple(first_search, second_search)
    assert_equal 4, queue.count
  end

  def test_it_prints_the_results_of_the_queue
    queue = Queue.new
    queue.repository = Finder.load_entries('event_attendees.csv')
    print_result =
      "+-----------+------------+-------------------------------+---------+--------+-------+----------------------+------------+
       | LAST NAME | FIRST NAME | EMAIL ADDRESS                 | ZIPCODE | CITY   | STATE | STREET               | HOME PHONE |
       +-----------+------------+-------------------------------+---------+--------+-------+----------------------+------------+
       | riordan   | sarah      | ctuhspugha@jumpstartlab.com   | 80212   | denver | co    | 2814 tennyson st.    | 7202058000 |
       | jenkins   | alexis     | sqcoomer11@jumpstartlab.com   | 80212   | denver | co    | 5020 w. moncrieff pl | 9285563000 |
       | joyce     | addison    | oxke.connery@jumpstartlab.com | 80222   | denver | co    | 1540 s. bellaire st  | 7088299000 |
       +-----------+------------+-------------------------------+---------+--------+-------+----------------------+------------+"
    queue.lookup("city", "denver")
    assert_equal print_result, queue.print_results
  end

  def test_it_prints_the_sorted_results_of_the_queue_after_print_by
    queue = Queue.new
    queue.repository = Finder.load_entries('event_attendees.csv')
    print_result =
      ["Jenkins		Alexis		sqcoomer11@jumpstartlab.com		80212		Denver		CO		5020 W. Moncrieff Pl		9285563000",
      "Joyce		Addison		oxke.connery@jumpstartlab.com		80222		Denver		CO		1540 S. Bellaire St		7088299000",
      "Riordan		Sarah		ctuhspugha@jumpstartlab.com		80212		Denver		CO		2814 Tennyson St.		7202058000"]
    queue.lookup("city", "denver")
    assert_equal print_result, queue.print_by("last_name")
  end

  def test_it_creates_a_csv
    queue = Queue.new
    queue.repository = Finder.load_entries('event_attendees.csv')
    queue.lookup("first_name", "tom")
    queue.save("testfile.csv")
    expected_csv = "swider,tom,srooddel@jumpstartlab.com,55057,northfield,mn,300 north college street,9184414000\n"
    actual_csv = IO.readlines("./data/testfile.csv")[3]
    assert_equal(expected_csv, actual_csv)
  end

end
