require_relative 'entry'

module Normalizer
  def self.normalize(data)
    if data == nil
    else data.downcase
    end
  end

  def self.normalize_phone_number(data)
    if data == nil
    else
      cleaned_array = data.gsub(/\D/, "").chars
      cleaned_array.insert(3, ".")
      cleaned_array.insert(7, ".")
      cleaned_array.join
    end
  end

  def self.normalize_zip_code(data)
    if data == nil
    else data.rjust(5, "0")
    end
  end
end
