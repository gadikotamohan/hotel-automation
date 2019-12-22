class Hotel
  attr_accessor :floors
  def initialize(num_of_floors, mc_per_floor, sc_per_floor, controller)
    self.floors = []
    num_of_floors.times {
      self.floors << Floor.new(mc_per_floor, sc_per_floor)
    }
    controller.add_observer(self)
  end

  def status
    status_str = ''
    self.floors.each_with_index do |floor, i|
      status_str << "Floor #{i+1}" + "\n"
      status_str << floor.status
    end
    status_str
  end

  def update(floor_no, sub_corridor_no, movement)
    if(floor_no < 1 || floor_no > self.floors.length)
      puts "Invalid Input: Floor #{floor_no} doesn't exist".red
      return
    end
    selected_floor = self.floors[floor_no-1]
    sub_corridors = selected_floor.sub_corridors
    if(sub_corridor_no < 1 || sub_corridor_no > sub_corridors.length)
      puts "Invalid Input: Floor #{floor_no} does not have sub corridor #{sub_corridor_no}".red
      return
    end
    sub_corridor = sub_corridors[sub_corridor_no-1]
    if movement # movement detected
      sub_corridor.movement_event
      sub_corridor.lights.map{ |light| light.power_on }
    else
      if sub_corridor.has_moved?
        sub_corridor.movement_stop_event
        sub_corridor.lights.map{ |light| light.power_off }
      end
    end
    # check if ac's need to be powered on
    selected_floor.check_and_reset_power
  end
end