gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/normalizer'

class NormalizerTest < Minitest::Test
  def test_it_normalizes_first_name
    data = {
      first_name: 'John',
      last_name: 'tAylor',
      email_address: 'johntaylor@gmail.com',
      phone_number: '(704) 346 3455',
      address: '1500 Blake Street',
      city: 'Denver',
      state: 'CO',
      zip_code: '80211'
    }

    assert_equal "john", Normalizer.normalize(data[:first_name])
  end

  def test_it_normalizes_last_name
    data = {
      first_name: 'john',
      last_name: 'TAylor',
      email_address: 'johntaylor@gmail.com',
      phone_number: '(704) 346 3455',
      address: '1500 Blake Street',
      city: 'Denver',
      state: 'CO',
      zip_code: '80211'
    }
    assert_equal "taylor", Normalizer.normalize(data[:last_name])
  end

  def test_it_normalizes_email_address
    data = {
      first_name: 'john',
      last_name: 'TAylor',
      email_address: 'johNtaylor@Gmail.com',
      phone_number: '(704) 346 3455',
      address: '1500 Blake Street',
      city: 'Denver',
      state: 'CO',
      zip_code: '80211'
    }
    assert_equal "johntaylor@gmail.com", Normalizer.normalize(data[:email_address])
  end

  def test_it_normalizes_phone_number
    data = {
      first_name: 'john',
      last_name: 'TAylor',
      email_address: 'johNtaylor@Gmail.com',
      phone_number: '(704) 346 3455',
    }
    assert_equal "704.346.3455", Normalizer.normalize_phone_number(data[:phone_number])

    data = {
      first_name: 'john',
      last_name: 'TAylor',
      email_address: 'johNtaylor@Gmail.com',
      phone_number: '704.346.3455',
    }
    assert_equal "704.346.3455", Normalizer.normalize_phone_number(data[:phone_number])
  end

  def test_it_normalizes_address
    data = {
      first_name: 'john',
      last_name: 'TAylor',
      email_address: 'johNtaylor@Gmail.com',
      phone_number: '(704) 346 3455',
      address: '1500 Blake Street',
      city: 'Denver',
      state: 'CO',
      zip_code: '80211'
    }
    assert_equal "1500 blake street", Normalizer.normalize(data[:address])
  end

  def test_it_normalizes_city
    data = {
      first_name: 'john',
      last_name: 'TAylor',
      city: 'Denver',
    }
    assert_equal "denver", Normalizer.normalize(data[:city])

    data = {
      first_name: 'john',
      last_name: 'TAylor',
      city: 'dEnver',
    }
    assert_equal "denver", Normalizer.normalize(data[:city])
  end

  def test_it_normalizes_state
    data = {
      first_name: 'john',
      last_name: 'TAylor',
      state: 'CO',
    }
    assert_equal "co", Normalizer.normalize(data[:state])

    data = {
      first_name: 'john',
      last_name: 'TAylor',
      state: 'Co',
    }
    assert_equal "co", Normalizer.normalize(data[:state])
  end

  def test_it_normalizes_zip_code
    data = {
      first_name: 'john',
      zip_code: '80211'
    }
    assert_equal "80211", Normalizer.normalize_zip_code(data[:zip_code])

    data = {
      first_name: 'john',
      zip_code: '211'
    }
    assert_equal "00211", Normalizer.normalize_zip_code(data[:zip_code])
  end
end
