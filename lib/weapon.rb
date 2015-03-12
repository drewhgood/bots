class Weapon < Item

  attr_reader :damage

  def initialize(name, weight, damage)
    @damage = damage
    super(name, weight)
  end

  def hit(robot)
    robot.wound(damage)
  end 

end