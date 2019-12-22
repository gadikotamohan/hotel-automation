require 'observer'
describe Controller do
  context "#initialize" do
    it "initializes Hotel object and controller object" do
      expect(Hotel).to receive(:new).with(any_args)
      expect(Controller).to include(Observable)
      Controller.new(1,2,2)
    end
  end

  context "#input" do
    it "should trigger MOVEMENT, STATUS, EXIT events" do
      controller = Controller.new(2,1,2)
      allow(controller).to receive(:gets).and_return "MOVEMENT", "2", "1", "STATUS", "EXIT"
      controller.input
    end

    it "should trigger NOMOVEMENT, MOVEMENT, STATUS, EXIT events" do
      controller = Controller.new(2,1,2)
      allow(controller).to receive(:gets).and_return "MOVEMENT", "2", "1", "STATUS", "MOVEMENT", "2", "2", "STATUS", "NOMOVEMENT", "2", "2", "STATUS", "EXIT"
      controller.input

    end
  end
end