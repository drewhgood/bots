require_relative 'heal_error'
require_relative 'attack_error'
require_relative 'item'

class Robot
  attr_accessor :position, :items, :items_weight, :health, :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @items_weight = 0
    @health = 100
    @equipped_weapon = nil
  end

  def attack!(target)
      raise AttackError, "can only attack robots" unless target.is_a? Robot
      attack(target)
  end

  def attack(target)
    if equipped_weapon
      self.equipped_weapon.hit(target)
    else
      target.wound(5)
    end
  end

  def heal!(amount)
      raise HealError, "unable heal a dead robot" if health <= 0
      heal(amount)
  end

  def heal(amount)
    if health + amount > 100
      @health = 100
    else
      @health += amount
    end
  end

  def wound(amount)
    if health - amount < 0
      @health = 0
    else
      @health -= amount
    end
  end

  def pick_up(item)


    if item.weight + items_weight > 250
      false
    else
      if item.is_a? Weapon
        @equipped_weapon = item
      end
      @items_weight += item.weight
      @items << item
    end
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

end

# rob = Robot.new
# it = Item.new('thing',22)
# rob.attack!(it)
