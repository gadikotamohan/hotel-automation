require 'pry'
Dir["./init/*.rb"].each {|file| require file }
Dir["./models/*.rb"].each {|file| require file }

print "Enter the number of Floors: "
floors = gets.chomp
print "Enter the number of Main Corridors: "
mc_per_floor = gets.chomp
print "Enter the number of Sub Corridors: "
sc_per_floor = gets.chomp

controller = Controller.new(floors.to_i, mc_per_floor.to_i, sc_per_floor.to_i)
controller.input