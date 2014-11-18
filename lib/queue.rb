require_relative 'finder'    # => true
require_relative 'messages'  # => true
require 'csv'
require 'pry'                # => true

class Queue
  attr_reader :repository, :messages  # => nil

  def initialize(repository = Finder.load_entries)
    @repository = repository
    @results = []
    @messages = Messages.new
  end

  def lookup(method, string)
    if method == "first_name"
      @results = repository.find_by_first_name(string)
    elsif method == "last_name"
      @results = repository.find_by_last_name(string)
    elsif method == "city"
      @results = repository.find_by_city(string)
    elsif method == "state"
      @results = repository.find_by_state(string)
    end
  end

  def clear
    @results = []
  end

  def count
    @results.count
  end

  def print_by(attribute)
    print_results.sort_by { |a| [a.attribute]}
    #need an output: puts "#{messages.header} + #{print_by(?)}" ??
  end


  def print_results
    @results.map do |result|
      "#{result.last_name}\t#{result.first_name}\t#{result.email_address}\t#{result.zip_code}\t#{result.city}\t#{result.state}\t#{result.address}\t#{result.phone_number}\t"
    end
  end

  def print_results_csv
    @results.map do |result|
      "#{result.last_name},#{result.first_name},#{result.email_address},#{result.zip_code},#{result.city},#{result.state},#{result.address},#{result.phone_number}"
      # [result.last_name,result.first_name,result.email_address,result.zip_code,result.city,result.state,result.address,result.phone_number]
    end
  end

  def save(file_name)
    CSV.open((file_name), "w") do |csv|
      csv << ["LAST NAME",	"FIRST NAME",	"EMAIL",	"ZIPCODE",	"CITY",	"STATE",	"ADDRESS",	"PHONE"]
      csv << print_results_csv
    end
  end
end
