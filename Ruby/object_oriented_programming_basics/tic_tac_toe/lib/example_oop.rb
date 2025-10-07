class Viking
  def initialize(name, age, health, strength)
    @name = name
    @age = age
    @health = health
    @strength = strength
  end
  # Same as above
  attr_accessor :name, :age, :health, :strength

  def attack(enemy)
    # code to fight
  end

  def take_damage(damage)
    self.health -= damage
    # OR we could have said @health -= damage
    self.shout("OUCH!")
  end

  def shout(str)
    puts str
  end

  def self.create_warrior(name)
    age = rand * 20 + 15   # remember, rand gives a random 0 to 1
    health = [age * 5, 120].min
    strength = [age / 2, 10].min
    Viking.new(name, health, age, strength)  # returned
  end
end
