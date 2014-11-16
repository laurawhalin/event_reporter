class Entry
  attr_reader :first_name,
              :last_name,
              :name,
              :email_address,
              :phone_number,
              :address,
              :city,
              :state,
              :zip_code

  def initialize(data)
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @email_address = data[:email_address]
    @phone_number = data[:phone_number]
    @address = data[:address]
    @city = data[:city]
    @state = data[:state]
    @zip_code = data[:zip_code]
  end

  def name
    "#{@first_name} #{@last_name}"
  end

end
