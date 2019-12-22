describe Hotel do
  before do
    @controller = double("Some controller")
    allow(@controller).to receive(:add_observer).with(an_instance_of(Hotel))
    @hotel = Hotel.new(2, 1, 2, @controller)
  end
  context "#initialize" do
    it "should have 2 floors" do
      expect(@hotel.floors.length).to eq(2)
    end
    it "controller should call add_observer method when creating Hotel object" do
      expect(@controller).to receive(:add_observer).with(an_instance_of(Hotel))
      @hotel = Hotel.new(2, 1, 2, @controller)
    end
  end

  context "#update" do
    it "should validate floor_no before processing event" do
      @hotel.update(-1, 2, false)
      expect { @hotel.update(-1, 2, false) }.to output("Invalid Input: Floor -1 doesn't exist.\n").to_stdout
    end
    it "should validate sub corridor number before processing event" do
      @hotel.update(1, 3, false)
      expect { @hotel.update(1, 3, false) }.to output("Invalid Input: Floor 1 does not have sub corridor 3.\n").to_stdout
    end
    it "should process events when valid arguments are passed" do
      floor = double("Some floor")
      sub_corridor = double("Some sub corridor")
      allow(@hotel).to receive(:floors).and_return([floor])
      allow(floor).to receive(:sub_corridors).and_return([sub_corridor])
      allow(floor).to receive(:check_and_reset_power).and_return(true)
      allow(sub_corridor).to receive(:has_moved?).and_return(false)
      expect(floor).to receive(:check_and_reset_power)
      @hotel.update(1, 1, false)
    end
  end
end