gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/entry'

class EntryTest < Minitest::Test
  def test_it_has_attributes
    data = {
      first_name: 'John',
      last_name: 'Taylor',
      email_address: 'johntaylor@gmail.com',
      phone_number: '(704) 346 3455',
      address: '1500 Blake Street',
      city: 'Denver',
      state: 'CO',
      zip_code: '211'
    }
    entry = Entry.new(data)

    assert_equal 'john', entry.first_name
    assert_equal 'taylor', entry.last_name
    assert_equal 'john taylor', entry.name
    assert_equal 'johntaylor@gmail.com', entry.email_address
    assert_equal '704.346.3455', entry.phone_number
    assert_equal '1500 blake street', entry.address
    assert_equal 'denver', entry.city
    assert_equal 'co', entry.state
    assert_equal '00211', entry.zip_code
  end
end
