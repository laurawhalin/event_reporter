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

  def header
    "LAST NAME\tFIRST NAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE\n"
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

  def list_of_find_arguments
    "first_name" || "last_name" || "email_address" || "phone_number" || "address" || "city" || "state" || "zip_code"
  end

  def save_confirmation(file)
    puts "The queue has been successfully saved to #{file}."
  end

end
