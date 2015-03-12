class Robot
  attr_accessor :position, :items, :items_weight, :health, :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @items_weight = 0
    @health = 100
    @equipped_weapon = nil
  end

  def enemy_in_range?(target)
    (equipped_weapon) ? range = self.equipped_weapon.range : range = 1
    diff = (self.position[1] - target.position[1]) 
    diff.abs <= range
  end

  def dispense_grenade
    @equipped_weapon = nil if self.equipped_weapon.is_a? Grenade
  end

  def attack!(target)
      raise AttackError, "can only attack robots" unless target.is_a? Robot
      attack(target)
  end

  def attack(target)
    if enemy_in_range?(target)
      equipped_weapon ? self.equipped_weapon.hit(target) : target.wound(5)
      dispense_grenade
    end
  end

  def heal!(amount)
      raise HealError, "unable to heal a dead robot" if health <= 0
      heal(amount)
  end

  def heal(amount)
    health + amount > 100 ? @health = 100 : @health += amount
  end

  def wound(amount)
    health - amount < 0 ? @health = 0 : @health -= amount
  end

  def autofeed_bolts?(item)
    (item.is_a? BoxOfBolts) && self.health <=80
  end

  def pick_up(item)
    item.feed(self) if autofeed_bolts?(item)
    if item.weight + items_weight > 250
      false
    else
      @equipped_weapon = item if item.is_a? Weapon
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
