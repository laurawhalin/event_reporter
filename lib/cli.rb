require_relative 'queue'
require_relative 'messages'

class CLI
  attr_reader :command, :outstream, :instream, :messages

  def initialize(instream, outstream)
    @command = ""
    @messages = Messages.new
    @instream = instream
    @outstream = outstream
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
    command[0] == "find"
  end

  def queue?
    command[0] == "queue"
  end

  def help?
    command[0] == "help"
  end

  def load?
    command[0] == "load"
  end

  def finished?
    command == "q" || command == "quit"
  end

  def process_search
    case
    when command[1] == "first_name"
      queue.lookup(command[1], command[2..-1])
    when command[1] == "last_name"
      queue.lookup(command[1], command[2..-1])
    when command[1] == "city"
      queue.lookup(command[1], command[2..-1])
    when command[1] == "state"
      queue.lookup(command[1], command[2..-1])
    when command[1] == "email_address"
      queue.lookup(command[1], command[2..-1])
    when command[1] == "zip_code"
      queue.lookup(command[1], command[2..-1])
    when command[1] == "phone_number"
      queue.lookup(command[1], command[2..-1])
    when command[1] == "address"
      queue.lookup(command[1], command[2..-1])
    end
  end

  def process_queue
    case
    when command[1] == "clear"
      queue.clear
    when command[1] == "count"
      queue.count
    when command[1] == "print" && command[2] == nil
      queue.print
    when command[1] == "print" && command[2] == by
      queue.print_by(command[3])
    when command[1] == "save"
      queue.save(command[-1])
    end
  end

  def load_file
    if command[1] == nil
      Finder.load_entries
    else
      Finder.load_entries(command[1])
    end
  end

end
