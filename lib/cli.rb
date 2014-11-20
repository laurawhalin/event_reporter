require_relative 'queue'
require_relative 'messages'

class CLI
  attr_reader :command,
              :arguments,
              :outstream,
              :instream,
              :messages,
              :queue,
              :first_search,
              :second_search

  def initialize(instream, outstream)
    @command        = ""
    @arguments      = ""
    @messages       = Messages.new
    @instream       = instream
    @outstream      = outstream
    @queue          = Queue.new
    @first_search   = Array.new
    @second_search  = Array.new
  end

  def call
    outstream.puts messages.intro
    outstream.puts messages.list_of_commands
    outstream.puts messages.file_request
    until finished?
      split_input(get_user_input)
      process_commands
    end
  end

  def get_user_input
    outstream.puts messages.command_request
    instream.gets.strip.downcase
  end

  def split_input(input)
    @command, *@arguments = input.split
  end

  def process_commands
    case command
    when "find"   then find_by
    when "queue"  then process_queue
    when "help"   then process_help
    when "load"   then load_file
    when "q"      then outstream.puts messages.exit_message
    when "quit"   then outstream.puts messages.exit_message
    else               outstream.puts messages.invalid_command
    end
  end

  def finished?
    command == "q" || command == "quit"
  end

  def find_by
    if arguments.length > 2 && arguments.include?("and")
      process_multiple_seach_criteria
    else
      process_single_search_criteria
    end
  end

  def process_multiple_seach_criteria
    lookup_multiple_arguments
    queue.lookup_multiple(first_search, second_search)
    outstream.puts messages.number_of_found_entries(queue)
  end

  def process_single_search_criteria
    if arguments[0] != nil && Entry.instance_methods.include?(arguments[0].to_sym)
      lookup_arguments
      outstream.puts messages.number_of_found_entries(queue)
    else
      outstream.puts messages.invalid_command
    end
  end

  def lookup_multiple_arguments
    @first_search.push(arguments[0], arguments[1])
    @second_search.push(arguments[3], arguments[4])
  end

  def lookup_arguments
    method = arguments.shift
    queue.lookup(method, arguments.join(' '))
  end

  def process_queue
    case arguments[0]
    when "clear" then queue.clear
    when "count" then puts outstream.puts messages.queue_count(queue)
    when "print" then process_print
    when "save"  then queue.save(arguments[2]) && messages.save_confirmation(arguments[2])
    else              outstream.puts messages.invalid_command
    end
  end

  def process_print
    case arguments[1]
    when nil
      outstream.puts queue.print_results
    when "by"
      outstream.puts messages.tab_delimited_header
      outstream.puts queue.print_by(arguments[2])
    else
      outstream.puts messages.invalid_command
    end
  end

  def process_help
    case arguments[0]
    when nil     then outstream.puts messages.help_options
    when "queue" then process_queue_help
    when "find"  then outstream.puts messages.find_description
    else              outstream.puts messages.invalid_command
    end
  end

  def process_queue_help
    outstream.puts messages.queue_help(arguments[1])
  end

  def load_file
    if arguments[0] == nil
      queue.repository = Finder.load_entries
      outstream.puts messages.file_loaded('event_attendees.csv')
    elsif file_exists?
      queue.repository = Finder.load_entries(arguments[0])
      outstream.puts messages.file_loaded(arguments[0])
    else
      outstream.puts messages.file_does_not_exist(arguments[0])
    end
  end

  def file_exists?
    File.exist?(arguments[0])
  end
end
