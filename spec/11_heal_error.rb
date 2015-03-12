require './spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe "#heal!" do
    it "should throw a custom heal error if trying to heal dead robot." do
      @robot.health = 0
      expect{@robot.heal!(100)}.to raise_error(HealError)
    end

    it "should be able to heal alive robots" do
      @robot.health = 1
      @robot.heal!(99)
      expect(@robot.health).to eq(100)
    end

  end

end


