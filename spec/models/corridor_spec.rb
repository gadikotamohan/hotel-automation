describe Corridor do
  subject do
    Corridor.new
  end
  context "#initialize" do
    it "should have lights, air_conditioners" do
      expect(subject.lights).not_to be(nil)
      expect(subject.air_conditioners).not_to be(nil)
      expect(subject.has_moved?).to be(false)
    end
  end

  context "#power_usage" do
    it "should return 0 as power usage" do
      expect(subject.power_usage).to be(0)
    end
    it "should return 5 when lights are turned on" do
      subject.air_conditioners.map(&:power_off)
      subject.lights.map(&:power_on)
      expect(subject.power_usage).to be(5)
    end
    it "should return 10 when ACs are turned on" do
      subject.lights.map(&:power_off)
      subject.air_conditioners.map(&:power_on)
      expect(subject.power_usage).to be(10)
    end
    it "should return 15 when lights and ACs are turned on" do
      subject.lights.map(&:power_on)
      subject.air_conditioners.map(&:power_on)
      expect(subject.power_usage).to be(15)
    end
  end
end