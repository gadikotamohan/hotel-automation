class Floor
  attr_accessor :main_corridors, :sub_corridors
  def initialize(no_of_main_corridors, no_of_sub_corridors)
    self.main_corridors = []
    self.sub_corridors = []
    no_of_main_corridors.times {
      corridor = Corridor.new
      corridor.lights.each { |light| light.power_on }
      corridor.air_conditioners.each { |ac| ac.power_on }
      self.main_corridors << corridor
    }

    no_of_sub_corridors.times {
      corridor = Corridor.new
      self.sub_corridors << corridor
    }
  end

  def check_and_reset_power
    return if power_usage == maximum_power_usage
    if power_usage < maximum_power_usage
      @sub_corridors.each do |sc|
        sc.air_conditioners.each {|ac| ac.power_on }
      end
    else
      catch (:turn_off_ac_s) do
        @sub_corridors.each do |sc|
          sc.air_conditioners.each do |ac|
            ac.power_off
            throw :turn_off_ac_s if power_usage <= maximum_power_usage
          end
        end
      end
    end
  end

  def status
    status_str = ''
    self.main_corridors.each_with_index do |mc, i|
      status_str << "  Main Corridor #{i+1} " + "\n"
      status_str << mc.status
    end
    self.sub_corridors.each_with_index do |sc, i|
      status_str << "  Sub Corridor #{i+1} " + "\n"
      status_str << sc.status
    end
    status_str
  end

  def power_usage
    self.main_corridors.inject(0) {|r, mc| r+=mc.power_usage } + self.sub_corridors.inject(0) {|r, sc| r+=sc.power_usage }
  end

  def maximum_power_usage
    self.main_corridors.length * 15 + self.sub_corridors.length * 10
  end
end