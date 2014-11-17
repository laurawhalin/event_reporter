require_relative 'queue'
require_relative 'messages'

class CLI
  attr_reader :command, :outstream, :instream, :messages, :queue

  def initialize(instream, outstream)
    @command = ""
    @messages = Messages.new
    @instream = instream
    @outstream = outstream
    @queue = Queue.new
  end

  def call
    outstream.puts messages.intro
    until finished?
      outstream.puts messages.command_request
      @command = instream.gets.strip
      process_commands
    end
  end

  private

  def process_commands
    case
    when find?
      process_search
    when queue?
      process_queue
    when help?
      process_help
    when load?
      load_file
    end
  end

  def find?
    parsed_command[0] == "find"
  end

  def queue?
    parsed_command[0] == "queue"
  end

  def help?
    parsed_command[0] == "help"
  end

  def load?
    parsed_command[0] == "load"
  end

  def finished?
    command == "q" || command == "quit"
  end

  def parsed_command
    command.split(" ")
  end

  def process_search
    case
    when parsed_command[1] == "first_name"
      if parsed_command[2] == parsed_command[-1]
        lookup = queue.lookup(parsed_command[1], parsed_command[2])
        puts "Found #{queue.count} results"
      else
        queue.lookup(parsed_command[1], parsed_command[2..-1])
        puts "Found #{queue.count} results"
      end
    when parsed_command[1] == "last_name"
      queue.lookup(parsed_command[1], parsed_command[2..-1])
    when parsed_command[1] == "city"
      queue.lookup(parsed_command[1], parsed_command[2..-1])
    when parsed_command[1] == "state"
      queue.lookup(parsed_command[1], parsed_command[2..-1])
    when parsed_command[1] == "email_address"
      queue.lookup(parsed_command[1], parsed_command[2..-1])
    when parsed_command[1] == "zip_code"
      queue.lookup(parsed_command[1], parsed_command[2..-1])
    when parsed_command[1] == "phone_number"
      queue.lookup(parsed_command[1], parsed_command[2..-1])
    when parsed_command[1] == "address"
      queue.lookup(parsed_command[1], parsed_command[2..-1])
    end
  end

  def process_queue
    case
    when parsed_command[1] == "clear"
      queue.clear
    when parsed_command[1] == "count"
      puts queue.count
    when parsed_command[1] == "print" && parsed_command[2] == nil
      queue.print_queue
    when parsed_command[1] == "print" && parsed_command[2] == by
      queue.print_by(parsed_command[3])
    when parsed_command[1] == "save"
      queue.save(parsed_command[-1])
    end
  end

  def load_file
    if parsed_command[1] == nil
      Finder.load_entries
    else
      Finder.load_entries(parsed_command[1])
    end
  end

end
