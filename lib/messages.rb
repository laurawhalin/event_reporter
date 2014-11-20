class Messages
  def intro
    "Welcome to Event Reporter."
  end

  def file_request
    "\nPlease load a file or simply type 'load' to load the default 'event_attendees.csv'"
  end

  def command_request
    "\nPlease enter a command. Type 'help' for a list of available commands."
  end

  def invalid_command
    "\nThis is an invalid command."
  end

  def exit_message
    "\nGoodbye"
  end

  def file_loaded(argument)
    puts "\nThe file #{argument} has been successfully loaded."
  end

  def tab_delimited_header
    "LAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE\n"
  end

  def csv_header
    ["LAST NAME", "FIRST NAME", "EMAIL ADDRESS", "ZIPCODE", "CITY", "STATE", "STREET", "HOME PHONE"]
  end

  def help_options
    puts "\n---------------------------------------"
    puts "'help'                - help menu"
    puts "'help' <command>      - command help"
    puts "options: find | queue | load"
    puts "---------------------------------------\n"
  end

  def find_description
    "\n'find <attribute> <criteria>' - Searches data for attendees that meet a specific search criteria."
  end

  def queue_help(argument)
    case argument
    when nil      then queue_description
    when "clear"  then queue_clear_description
    when "count"  then queue_count_description
    when "print"  then queue_print_description
    when "save"   then queue_save_description
    else               invalid_command
    end
  end

  def queue_description
    "\n'queue <command>' - The Queue holds all of the data from the current search until it is exported, cleared, or the next search is executed using the 'find <attribute> <criteria>' command.\nSee also: 'queue count', 'queue clear', 'queue print', and 'queue save to'"
  end

  def queue_clear_description
    "\n'queue clear' - Removes all attendee records from the current queue."
  end

  def queue_count_description
    "\n'queue count' - returns the total number of attendee records in the current queue."
  end

  def queue_print_description
    "\n'queue print' - Displays a data table of all attendee records in the current queue.\n'queue print by <attribute>' takes an attribute and displays a data table of all attendee records in the current queue sorted by that attribute."
  end

  def queue_save_description
    "\n'queue save to <filename>' - Exports all data in the current queue to a csv with a name of your choosing."
  end

  def save_confirmation(file)
    puts "The queue has been successfully saved to #{file}."
  end

  def titlize(attribute)
    words = attribute.split(' ')
    if words[1] == nil
      attribute.capitalize
    else
      words.map! do |word|
        word.capitalize
      end
      words.join(" ")
    end
  end

  def print_formatted_queue_results(result)
    "#{titlize(result.last_name)}\t\t#{titlize(result.first_name)}\t\t#{result.email_address}\t\t#{result.zip_code}\t\t#{titlize(result.city)}\t\t#{result.state.upcase}\t\t#{titlize(result.address)}\t\t#{result.phone_number}"
  end

  def print_formatted_results_for_csv(result)
    [result.last_name,result.first_name,result.email_address,result.zip_code,result.city,result.state,result.address,result.phone_number]
  end

  def no_file_loaded
    "\nNo file has been loaded.#{file_request}"
  end

  def number_of_found_entries(queue)
    "\nFound #{queue.count} entries"
  end

  def queue_count(queue)
    "\n#{queue.count} entries"
  end

end
