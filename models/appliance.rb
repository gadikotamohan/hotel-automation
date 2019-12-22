# AC/Light or any electric appliances
class Appliance
  attr_accessor :power, :state
  def intialize(state, power)
    self.state = STATE.values.include?(state) ? state : throw "Invalid Appliance state"
    self.power = power
  end

  def power_usage
    state == STATE[:on] ? self.power : 0
  end

  def power_on
    self.state = STATE[:on]
  end

  def power_off
    self.state = STATE[:off]
  end
end