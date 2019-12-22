class Corridor
  attr_accessor :lights, :air_conditioners
  def intialize
    self.lights = [Appliance.new(STATUS[:off], DEFAULT_UNITS[:lights])]
    self.air_conditioners = [Appliance.new(STATUS[:off], DEFAULT_UNITS[:ac])]
    @movement = false
  end

  def status
    status_str = ''
    self.lights.each_with_index do |light, i|
      status_str << "    Light #{i+1}: #{light.status}" + "\n"
    end
    self.air_conditioners.each_with_index do |ac, i|
      status_str << "    AC #{i+1}: #{ac.status}" + "\n"
    end
    status_str
  end

  def movement_event
    @movement = true
  end

  def movement_stop_event
    @movement = false
  end

  def has_moved?
    @movement
  end

  def power_on_lights
    self.lights.map{ |light| light.power_on }
  end

  def power_off_lights
    self.lights.map{ |light| light.power_off }
  end

  def power_usage
    self.lights.inject(0){ |r,light| r += light.power_usage } + self.air_conditioners.inject(0) { |r,ac| r += ac.power_usage }
  end

end