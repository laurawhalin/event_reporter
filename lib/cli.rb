require_relative 'queue'
require_relative 'messages'

class CLI
  attr_reader :command, :arguments, :outstream, :instream, :messages, :queue

  def initialize(instream, outstream)
    @command    = ""
    @arguments  = ""
    @messages   = Messages.new
    @instream   = instream
    @outstream  = outstream
    @queue      = Queue.new
  end

  def call
    outstream.puts messages.intro
    outstream.puts messages.file_request
    until finished?
      split_input
      process_commands
    end
  end

  def get_input
    outstream.puts messages.command_request
    instream.gets.strip
  end

  def split_input
    @command, *@arguments = get_input.split
  end

  def process_commands
    case command
    when "find"         then process_search(arguments)
    when "queue"        then process_queue(arguments)
    when "help"         then process_help(arguments)
    when "load"         then load_file(arguments) && messages.file_loaded(arguments[0])
    when "q" || "quit"  then outstream.puts messages.exit_message
    else                     outstream.puts messages.invalid_command
    end
  end

  def finished?
    command == "q" || command == "quit"
  end

  def process_search(arguments)
    method = arguments.shift
    queue.lookup(method, arguments.join(' '))
    puts "Found #{queue.count} entries"
  end

  def process_queue(arguments)
    case arguments[0]
    when "clear" then queue.clear
    when "count" then puts queue.count
    when "print" then process_print(arguments)
    when "save"  then queue.save(arguments[2])
    else              outstream.puts messages.invalid_command
    end
  end

  def process_print(arguments)
    case arguments[1]
    when nil  then queue.print_queue
    when "by" then queue.print_by(argument[2])
    else           outstream.puts messages.invalid_command
    end
  end

  def process_help(arguments)
    case arguments[0]
    when nil     then outstream.puts messages.help_options
    when "queue" then process_queue_help(arguments)
    when "find"  then outstream.puts messages.find_description
    else              outstream.puts messages.invalid_command
    end
  end

  def process_queue_help(arguments)
    case arguments[1]
    when nil     then outstream.puts messages.queue_description
    when "clear" then outstream.puts messages.queue_clear_description
    when "count" then outstream.puts messages.queue_count_description
    when "print" then outstream.puts messages.queue_print_description
    when "save"  then outstream.puts messages.queue_save_description
    else              outstream.puts messages.invalid_command
    end
  end

  def file_loaded?
    @initial_command.start_with?("load")
  end

  def load_file(arguments)
    if arguments[0] == nil
      Finder.load_entries
    else
      Finder.load_entries(arguments[0])
    end
  end

end
