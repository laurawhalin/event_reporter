require_relative '../test_helper'
require_relative '../lib/finder'

class FinderTest < Minitest::Test
  def test_find_by_first_name
    entries = [
      { first_name: 'John', last_name: 'Taylor', phone_number: '111.111.1111' },
      { first_name: 'Bob', last_name: 'Smith', phone_number: '222.222.2222' },
      { first_name: 'Cindy', last_name: 'Johnson', phone_number: '333.333.3333' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by('first_name', 'john')
    assert_equal 1, entries.length
  end

  def test_find_by_first_name_with_multiple_returns
    entries = [
      { first_name: 'John', last_name: 'Taylor', phone_number: '111.111.1111' },
      { first_name: 'John', last_name: 'Smith', phone_number: '222.222.2222' },
      { first_name: 'Cindy', last_name: 'Johnson', phone_number: '333.333.3333' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by('first_name', 'john')
    assert_equal 2, entries.length
  end

  def test_find_by_last_name
    entries = [
      { first_name: 'John', last_name: 'Taylor', phone_number: '111.111.1111' },
      { first_name: 'Bob', last_name: 'Smith', phone_number: '222.222.2222' },
      { first_name: 'Cindy', last_name: 'Johnson', phone_number: '333.333.3333' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by('last_name', 'taylor')
    assert_equal 1, entries.length
  end

  def test_find_by_last_name_with_multiple_returns
    entries = [
      { first_name: 'John', last_name: 'Taylor', phone_number: '111.111.1111' },
      { first_name: 'Bob', last_name: 'Taylor', phone_number: '222.222.2222' },
      { first_name: 'Cindy', last_name: 'Johnson', phone_number: '333.333.3333' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by('last_name', 'taylor')
    assert_equal 2, entries.length
  end

  def test_find_by_city
    entries = [
      { first_name: 'John', last_name: 'Taylor', phone_number: '111.111.1111', city: 'Denver' },
      { first_name: 'Bob', last_name: 'Smith', phone_number: '222.222.2222', city: 'Tuscon' },
      { first_name: 'Cindy', last_name: 'Johnson', phone_number: '333.333.3333', city: 'New York' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by('city', 'denver')
    assert_equal 1, entries.length
  end

  def test_find_by_city_with_multiple_returns
    entries = [
    { first_name: 'John', last_name: 'Taylor', phone_number: '111.111.1111', city: 'Denver' },
    { first_name: 'Bob', last_name: 'Smith', phone_number: '222.222.2222', city: 'Denver' },
    { first_name: 'Cindy', last_name: 'Johnson', phone_number: '333.333.3333', city: 'New York' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by('city', 'denver')
    assert_equal 2, entries.length
  end

  def test_find_by_state
    entries = [
      { first_name: 'John', last_name: 'Taylor', state: 'CO' },
      { first_name: 'Bob', last_name: 'Smith', state: 'MD' },
      { first_name: 'Cindy', last_name: 'Johnson', state: 'NY' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by('state', 'co')
    assert_equal 1, entries.length
  end

  def test_find_by_state_with_multiple_returns
    entries = [
      { first_name: 'John', last_name: 'Taylor', state: 'CO' },
      { first_name: 'Bob', last_name: 'Smith', state: 'CO' },
      { first_name: 'Cindy', last_name: 'Johnson', state: 'NY' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by('state', 'co')
    assert_equal 2, entries.length
  end

  def test_find_by_email_address
    entries = [
      { first_name: 'John', last_name: 'Taylor', email_address: 'jjtaylor@email.com' },
      { first_name: 'Bob', last_name: 'Smith', email_address: 'mrsomeone@email.com' },
      { first_name: 'Cindy', last_name: 'Johnson', email_address: 'skippy@email.com' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by('email_address', 'jjtaylor@email.com')
    assert_equal 1, entries.length
  end

  def test_find_by_phone_number
    entries = [
      { first_name: 'John', last_name: 'Taylor', homephone: '(303) 333-3333' },
      { first_name: 'Bob', last_name: 'Smith', homephone: '720-220-2200' },
      { first_name: 'Cindy', last_name: 'Johnson', homephone: '(505) 555-5555' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by('phone_number', '3033333333')
    assert_equal 1, entries.length
  end

  def test_find_by_address
    entries = [
      { first_name: 'John', last_name: 'Taylor', street: '3311 Main Street' },
      { first_name: 'Bob', last_name: 'Smith', street: '4545 North Way' },
      { first_name: 'Cindy', last_name: 'Johnson', street: 'P.O. Box 234' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by('address', '3311 main street')
    assert_equal 1, entries.length
  end

  def test_find_by_zip_code
    entries = [
      { first_name: 'John', last_name: 'Taylor', zipcode: '80122' },
      { first_name: 'Bob', last_name: 'Smith', zipcode: '12345' },
      { first_name: 'Cindy', last_name: 'Johnson', zipcode: '00123' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by('zip_code', '80122')
    assert_equal 1, entries.length
  end

  def test_improved_find_finds_by_two_attributes
    entries = [
      { first_name: 'Sarah', last_name: 'Taylor', state: 'CA' },
      { first_name: 'Sarah', last_name: 'Smith', state: 'CO' },
      { first_name: 'Cindy', last_name: 'Johnson', state: 'CA' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by_two('first_name', 'sarah', 'state', 'ca')
    assert_equal 1, entries.length
  end

end
