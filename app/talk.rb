class Talk
  def initialize(event_name, talk_name, time_start, time_end, speaker)
    @event_name = event_name
    @talk_name = talk_name
    @time_start = time_start
    @time_end = time_end
    @speaker = speaker
  end

  def event_name
    @event_name
  end

  def talk_name
    @talk_name
  end

  def time_start
    @time_start
  end

  def time_end
    @time_end
  end

  def speaker
    @speaker
  end
end
