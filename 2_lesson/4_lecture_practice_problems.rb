#1

# class Dog
#   def speak
#     'bark!'
#   end

#   def swim
#     'swimming!'
#   end
# end

# class Bulldog < Dog
#   def swim
#     "can't swim"
#   end
# end

# teddy = Bulldog.new
# puts teddy.speak           # => "bark!"
# puts teddy.swim           # => "swimming!"
# p Bulldog.ancestors

#2

class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Cat < Animal
  def speak
    'meow!'
  end
end

class Dog < Animal
  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end

  def speak
    'bark!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim"
  end
end

pete = Animal.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

p pete.run                # => "running!"
#pete.speak              # => NoMethodError

p kitty.run               # => "running!"
p kitty.speak             # => "meow!"
#kitty.fetch             # => NoMethodError

p dave.speak              # => "bark!"

p bud.run                 # => "running!"
p bud.swim                # => "can't swim!"