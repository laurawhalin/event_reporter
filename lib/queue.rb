require_relative 'finder'
require_relative 'messages'
require 'csv'

class Queue
  attr_reader   :messages, :results
  attr_accessor :repository

  def initialize
    @results  = []
    @messages = Messages.new
  end

  def lookup(criteria, attribute)
    case
    when repository_loaded? then @results = repository.find_by(criteria, attribute)
    else puts messages.no_file_loaded
    end
  end

  def lookup_multiple(first_criteria, first_attribute, second_criteria, second_attribute)
    case
    when repository_loaded? then @results = repository.find_by_two(first_criteria, first_attribute, second_criteria, second_attribute)
    else puts messages.no_file_loaded
    end
  end

  def repository_loaded?
    repository != nil
  end

  def clear
    @results = []
  end

  def count
    results.count
  end

  def print_results
    results.map do |result|
      messages.print_formatted_queue_results(result)
    end
  end

  def sort_by(attribute)
    results.sort_by! do |result|
      result.send(attribute)
    end
  end

  def print_by(attribute)
    sort_by(attribute)
    results.map do |result|
      messages.print_formatted_queue_results(result)
    end
  end

 def format_results_for_csv
    results.map do |result|
      messages.print_formatted_results_for_csv(result)
    end
  end

  def save(file_name)
    CSV.open("./data/#{file_name}", "w+") do |csv|
      csv << messages.csv_header
      format_results_for_csv.each do |result|
        csv << result
      end
    end
  end
end
