require 'observer'
class Controller
  include Observable
  attr_accessor :hotel
  def initialize(floors, mc_per_floor, sc_per_floor)
    self.hotel = Hotel.new(floors, mc_per_floor, sc_per_floor, self)
  end

  def input
    loop do
      puts 'Enter any of the commands: MOVEMENT, STATUS, EXIT, NOMOVEMENT'
      command = gets.chomp.downcase
      if command.empty? || command == 'status' || command == 's'
        puts hotel.status
      elsif command == 'exit' || command == 'q!' || command == 'e'
        puts 'Adios!'
        break
      elsif command == 'movement' || command == 'm'
        print 'Enter floor number: '
        floor = gets.chomp.to_i
        print 'Enter Sub Corridor number: '
        sub_corridor = gets.chomp.to_i
        changed
        notify_observers(floor, sub_corridor, true)
      elsif command == 'nomovement' || command == 'n'
        print 'Enter floor number: '
        floor = gets.chomp.to_i
        print 'Enter Sub Corridor number: '
        sub_corridor = gets.chomp.to_i
        changed
        notify_observers(floor, sub_corridor, false)
      end
    end
  end
end