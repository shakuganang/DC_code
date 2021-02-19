require './event'
require './speaker'
require './talk'
require './application_helper'
require './array'
require 'time'
include ApplicationHelper

class CLI
  events = []
  speakers = []
  talks = []

  commands =  "COMMANDS :\n" +
      "CREATE EVENT event_name\n" +
      "CREATE SPEAKER speaker_name\n" +
      "CREATE TALK event_name talk_name talk_start_time talk_end_time speaker_name\n" +
      "PRINT TALKS event_name => output the talks for an event sorted by the start time\n"
  prompt = "\nEnter a command or Q to quit:"

  puts commands
  puts prompt

  while (user_input = STDIN.gets.chomp) # loop while getting user input
    input_command = user_input.split[0..1].join(' ')
    case input_command
    when "Q"
      exit
    when "PRINT TALKS"
      found_talks = talks.find_by_event_name(user_input.split.last)
      found_talks.empty? ? print_no_valid(user_input.split.last) : print_talk_info(found_talks)
    when "CREATE EVENT"
      if events.event_exists?(user_input.split.last)
        print_exists("Event")
      else
        new_event = Event.new(user_input.split.last)
        events << new_event
      end
    when "CREATE SPEAKER"
      if speakers.speaker_exists?(user_input.split.last)
        print_exists("Speaker")
      else
        new_speaker = Speaker.new(user_input.split.last)
        speakers << new_speaker
      end
    when "CREATE TALK"
      split_input = user_input.split
      event_name = split_input[2]
      talk_name = user_input.split("'")[1].to_s
      time_start = find_time(split_input, true)
      time_end = find_time(split_input, false)
      speaker = split_input.last

      # find talks by event_name and check no time overlap
      overlapping = no_talk_overlap?(talks.find_by_event_name(event_name), time_start, time_end)

      if !events.event_exists?(event_name) || !speakers.speaker_exists?(speaker) || talk_name.empty? || time_start.nil? || time_end.nil? || overlapping
        # validate create input section
        print_missing("Event name") unless events.event_exists?(event_name)
        print_missing("Talk name") if talk_name.empty?
        print_invalid("Start time") if time_start.nil?
        print_invalid("End time") if time_end.nil?
        print_invalid("Start or End Time, there is an overlapping talk.") if overlapping
        print_missing("Speaker") unless speakers.speaker_exists?(speakers)
        puts prompt # print the prompt, so the user knows to re-enter input
      else
        new_talk = Talk.new(event_name, talk_name, time_start, time_end, speaker)
        talks << new_talk
        talks.sort_by! { |talk| talk.time_start } # Keep in time order for print time
      end
    else
      puts prompt # print the prompt, so the user knows to re-enter input
    end
  end
end
