class Entry
  attr_reader :first_name, :last_name, :phone_number

  def initialize(data)
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @phone_number = data[:phone_number]
  end

  def name
    "#{@first_name} #{@last_name}"
  end

end
