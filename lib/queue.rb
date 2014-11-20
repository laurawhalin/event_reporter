require_relative 'finder'
require_relative 'messages'
require 'csv'
require 'terminal-table'

class Queue
  attr_reader :repository, :messages

  def initialize(repository = Finder.load_entries)
    @repository = repository
    @results = []
    @messages = Messages.new
  end

  def lookup(attribute, string)
    @results = repository.find_by(attribute, string)
  end

  def clear
    @results = []
  end

  def count
    @results.count
  end

  # def print_results
  #   @results.map do |result|
  #     messages.print_formatted_queue_results(result)
  #   end
  # end

  def sort_by(attribute)
    @results.sort_by! do |result|
      result.send(attribute)
    end
  end

  def print_by(attribute)
    sort_by(attribute)
    @results.map do |result|
      messages.print_formatted_queue_results(result)
    end
  end

 def print_results_for_csv
    @results.map do |result|
      [result.last_name,result.first_name,result.email_address,result.zip_code,result.city,result.state,result.address,result.phone_number]
    end
  end

  def save(file_name)
    CSV.open("./data/#{file_name}", "w+") do |csv|
      csv << messages.csv_header
      print_results_for_csv.each do |result|
        csv << result
      end
    end
  end

  def print_results
    # require 'pry'; binding.pry
    rows = []
    print_results_for_csv.map do |entry|
      rows << entry
    end
    table = Terminal::Table.new :headings => messages.csv_header, :rows => rows
    puts table
  end
end
