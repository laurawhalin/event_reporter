require_relative '../test_helper'
require_relative '../lib/entry'

class EntryTest < Minitest::Test
  def test_it_has_attributes
    data = {
      first_name: 'John',
      last_name: 'Taylor',
      email_address: 'johntaylor@gmail.com',
      homephone: '(704) 346 3455',
      street: '1500 Blake Street',
      city: 'Denver',
      state: 'CO',
      zipcode: '211'
    }
    entry = Entry.new(data)

    assert_equal 'john', entry.first_name
    assert_equal 'taylor', entry.last_name
    assert_equal 'johntaylor@gmail.com', entry.email_address
    assert_equal '7043463455', entry.phone_number
    assert_equal '1500 blake street', entry.address
    assert_equal 'denver', entry.city
    assert_equal 'co', entry.state
    assert_equal '00211', entry.zip_code
  end
end
