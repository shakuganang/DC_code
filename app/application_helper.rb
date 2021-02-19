module ApplicationHelper
  def print_talk_info(talks)
    talks.each do |talk|
      puts "#{talk.time_start.strftime('%I:%M %p')} - #{talk.time_end.strftime('%I:%M %p')}\n" +
               "  #{talk.talk_name} presented by #{talk.speaker}"
    end
  end

  def print_no_valid(name)
    puts "Could not valid result for #{name}."
  end

  def print_exists(name)
    puts "#{name} already exists."
  end

  def print_missing(name)
    puts "#{name} does not exist."
  end

  def print_invalid(name)
    puts "Invalid #{name}."
  end

  # @param [string] user_input
  # @param [Boolean] Start = true | End = false
  def find_time(input, start_end)
    pos = start_end ? 3 : 2 # position from the end of user input
    DateTime.strptime(input[input.length - pos], "%I:%M%p") rescue nil
  end

  def no_talk_overlap?(current_talks, new_start, new_end)
    return true if new_start.nil? || new_end.nil?
    current_talks.each do |talk|
      # There is overlap if any start or end time is in between an existing talk's start or end
      return false if (talk.time_start < new_start && new_start < talk.time_end) ||
          (talk.time_start < new_end && new_end < talk.time_end)
    end
    true
  end

end
