require './spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
    @weapon = PlasmaCannon.new 
    @non_robot = BoxOfBolts.new
  end

  describe "#attack!" do
    it "should not be able to attack non robots" do
      expect{@robot.attack!(@non_robot)}.to raise_error(AttackError)
    end
 

    it "should be able to attack Robots" do
      @robot2 = Robot.new
      @robot2.health = 100
      @robot.attack!(@robot2)
      expect(@robot2.health).to be < 100
    end

  end

end
