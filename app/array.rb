class Array
  def find_by_event_name(name)
    self.select { |obj| obj.event_name == name }
  end

  def event_exists?(name)
    !self.find { |obj| obj.event_name == name }.nil?
  end

  def speaker_exists?(name)
    !self.find { |obj| obj.speaker_name == name }.nil?
  end
end