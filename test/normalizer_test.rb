gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/normalizer'

class NormalizerTest < Minitest::Test
  def test_it_takes_in_data
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
  end

  def test_it_normalizes_first_name
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
  end

  def test_it_normalizes_last_name
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
  end

  def test_it_normalizes_email_address
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
  end

  def test_it_normalizes_phone_number
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
  end

  def test_it_normalizes_address

  end

  def test_it_normalizes_city

  end

  def test_it_normalizes_state

  end

  def test_it_normalizes_zip_code

  end
end
