#1 

puts "Hello".class
puts 5.class
puts [1, 2, 3].class

# 2

class Cat
end

#3

kitty = Cat.new

#4

class Cat
  def initialize
    puts "I'm a cat!"
  end
end

paws = Cat.new

#5

class Cat
  def initialize(name)
    @name = name
    puts "Hello! My name is #{@name}!"
  end
end

paws = Cat.new('Sophie')

#6

class Cat
  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{@name}!"
  end
end

whiskers = Cat.new('Whiskers')
whiskers.greet

#7

class Cat
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

whiskers = Cat.new('Whiskers')
whiskers.greet

#8

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

whiskers = Cat.new('Whiskers')
whiskers.greet
whiskers.name = 'Luna'
whiskers.greet

#10

module Walkable

  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  include Walkable
  
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Luna')
kitty.greet
kitty.walk