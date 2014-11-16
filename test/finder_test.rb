gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/finder'

class FinderTest < Minitest::Test
  def test_find_by_first_name
    entries = [
      { first_name: 'John', last_name: 'Taylor', phone_number: '111.111.1111' },
      { first_name: 'Bob', last_name: 'Smith', phone_number: '222.222.2222' },
      { first_name: 'Cindy', last_name: 'Johnson', phone_number: '333.333.3333' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by_first_name('John')
    assert_equal 1, entries.length
  end

  def test_find_by_first_name_with_multiple_returns
    entries = [
      { first_name: 'John', last_name: 'Taylor', phone_number: '111.111.1111' },
      { first_name: 'John', last_name: 'Smith', phone_number: '222.222.2222' },
      { first_name: 'Cindy', last_name: 'Johnson', phone_number: '333.333.3333' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by_first_name('John')
    assert_equal 2, entries.length
  end

  def test_find_by_last_name
    entries = [
      { first_name: 'John', last_name: 'Taylor', phone_number: '111.111.1111' },
      { first_name: 'Bob', last_name: 'Smith', phone_number: '222.222.2222' },
      { first_name: 'Cindy', last_name: 'Johnson', phone_number: '333.333.3333' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by_last_name('Taylor')
    assert_equal 1, entries.length
  end

  def test_find_by_last_name_with_multiple_returns
    entries = [
      { first_name: 'John', last_name: 'Taylor', phone_number: '111.111.1111' },
      { first_name: 'Bob', last_name: 'Taylor', phone_number: '222.222.2222' },
      { first_name: 'Cindy', last_name: 'Johnson', phone_number: '333.333.3333' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by_last_name('Taylor')
    assert_equal 2, entries.length
  end

  def test_find_by_city
    entries = [
      { first_name: 'John', last_name: 'Taylor', phone_number: '111.111.1111', city: 'Denver' },
      { first_name: 'Bob', last_name: 'Smith', phone_number: '222.222.2222', city: 'Tuscon' },
      { first_name: 'Cindy', last_name: 'Johnson', phone_number: '333.333.3333', city: 'New York' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by_city('Denver')
    assert_equal 1, entries.length
  end

  def test_find_by_city_with_multiple_returns
    entries = [
    { first_name: 'John', last_name: 'Taylor', phone_number: '111.111.1111', city: 'Denver' },
    { first_name: 'Bob', last_name: 'Smith', phone_number: '222.222.2222', city: 'Denver' },
    { first_name: 'Cindy', last_name: 'Johnson', phone_number: '333.333.3333', city: 'New York' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by_city('Denver')
    assert_equal 2, entries.length
  end

  def test_find_by_state
    entries = [
      { first_name: 'John', last_name: 'Taylor', state: 'CO' },
      { first_name: 'Bob', last_name: 'Smith', state: 'MD' },
      { first_name: 'Cindy', last_name: 'Johnson', state: 'NY' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by_state('CO')
    assert_equal 1, entries.length
  end

  def test_find_by_state_with_multiple_returns
    entries = [
      { first_name: 'John', last_name: 'Taylor', state: 'CO' },
      { first_name: 'Bob', last_name: 'Smith', state: 'CO' },
      { first_name: 'Cindy', last_name: 'Johnson', state: 'NY' }
    ].map { |row| Entry.new(row) }

    finder = Finder.new(entries)
    entries = finder.find_by_state('CO')
    assert_equal 2, entries.length
  end
end
