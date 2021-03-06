require_relative 'normalizer'

class Entry
  attr_reader :first_name,
              :last_name,
              :name,
              :email_address,
              :phone_number,
              :address,
              :city,
              :state,
              :zip_code,
              :values

  def initialize(data)
    @first_name     = Normalizer.normalize(data[:first_name])
    @last_name      = Normalizer.normalize(data[:last_name])
    @email_address  = Normalizer.normalize(data[:email_address])
    @phone_number   = Normalizer.normalize_phone_number(data[:homephone])
    @address        = Normalizer.normalize(data[:street])
    @city           = Normalizer.normalize(data[:city])
    @state          = Normalizer.normalize(data[:state])
    @zip_code       = Normalizer.normalize_zip_code(data[:zipcode])
  end
end
