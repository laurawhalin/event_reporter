gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/entry'

class EntryTest < Minitest::Test
  def test_it_has_attributes
    data = {
      first_name: 'john',
      last_name: 'tAylor',
      email_address: 'johntaylor@gmail.com',
      phone_number: '(704) 346 3455',
      address: '1500 Blake Street',
      city: 'Denver',
      state: 'CO',
      zip_code: '80211'
    }
    entry = Entry.new(data)

    assert_equal 'John', entry.first_name
    assert_equal 'Taylor', entry.last_name
    assert_equal 'John Taylor', entry.name
    assert_equal 'johntaylor@gmail.com', entry.email_address
    assert_equal '(704) 346 3455', entry.phone_number
    assert_equal '1500 Blake Street', entry.address
    assert_equal 'Denver', entry.city
    assert_equal 'CO', entry.state
    assert_equal '80211', entry.zip_code
  end
end
