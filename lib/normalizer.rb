module Normalizer
  def self.normalize(data)
    if data == nil
    else data.downcase
    end
  end

  def self.normalize_phone_number(data)
    if data == nil
    else
      data.gsub(/\D/, "")
    end
  end

  def self.normalize_zip_code(data)
    if data == nil
    else data.rjust(5, "0")
    end
  end
end
