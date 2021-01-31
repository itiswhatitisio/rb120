#1

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting
kitty = Cat.new
kitty.class.generic_greeting

#2

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename(new_name)
    @name = new_name # instance variables
  end
end

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename(new_name)
    self.name = new_name # invoking a setter method
  end
end

kitty = Cat.new('Sophie')
p kitty.name
kitty.rename('Chloe')
p kitty.name

#3

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def identify
    self
  end
end

kitty = Cat.new('Sophie')
p kitty.identify # invoking self is the same as invoking kitty
p kitty
# self refers to its calling object

#4

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end

  def personal_greeting
    puts "Hello! My name is #{name}" #when should I use self?
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting

#5

class Cat
  @@total_number_of_cats = 0

  def initialize
    @@total_number_of_cats += 1
  end

  def self.total
    puts @@total_number_of_cats
  end
end

kitty1 = Cat.new
kitty2 = Cat.new

Cat.total

#6

class Cat
  attr_reader :name
  COLOUR = 'purple'

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name} and I'm a #{COLOUR} cat!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet

#7

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "I'm #{name}!"
  end
end

kitty = Cat.new('Sophie')
puts kitty

#8

class Person

  def secret=(s)
    @secret = s
  end

  def secret
    @secret
  end
end

# ^^ the code above equals to the code below 

class Person
  attr_accessor :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
puts person1.secret

#9

class Person
  attr_writer :secret

  def share_secret
    puts secret # it is not possible to invoke self. on getter/setter methods
  end

  private

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret! - exercise 9'
person1.share_secret

#10

class Person
  attr_writer :secret

  def compare_secret(b)
    secret == b
  end

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)
