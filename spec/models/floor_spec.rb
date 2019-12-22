describe Floor do
  subject do
    Floor.new(1, 2)
  end

  context "#initialize" do
    it "should have 1 main corridor" do
      expect(subject.main_corridors.length).to be(1)
    end
    it "should turn on all air conditioners and lights in main corridors" do
      subject.main_corridors.each do |corridor|
        corridor.lights.each do |light|
          expect(light.state).to be(STATE[:on])
        end
        corridor.air_conditioners.each do |ac|
          expect(ac.state).to be(STATE[:on])
        end
      end
    end
    it "should turn off all air conditioners and lights in sub corridors" do
      subject.sub_corridors.each do |corridor|
        corridor.lights.each do |light|
          expect(light.state).to be(STATE[:off])
        end
        corridor.air_conditioners.each do |ac|
          expect(ac.state).to be(STATE[:off])
        end
      end
    end
    it "should have 2 main corridor" do
      expect(subject.sub_corridors.length).to be(2)
    end
  end
  context "#check_and_reset_power" do
    it "when called upon, power consumption shouldn't exceed maximum power usage, 35 units" do
      subject.sub_corridors.each do |corridor|
        corridor.lights.each do |light|
          light.power_on
        end
        corridor.air_conditioners.each do |ac|
          ac.power_on
        end
      end
      subject.check_and_reset_power
      expect(subject.power_usage).to be <=35
    end
  end
  context "#power_usage" do
    it "should have 15 units of power usage" do
      expect(subject.power_usage).to be(15)
    end
  end
  context "#maximum_power_usage" do
    it "should have 35 units as maximum power usage" do
      expect(subject.maximum_power_usage).to be(35)
    end
  end
end