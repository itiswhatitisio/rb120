## Question 1

# class Greeting
#   def greet(message)
#     puts message
#   end
# end

# class Hello < Greeting
#   def hi
#     greet("Hello")
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end

# hello = Hello.new
# hello.hi # Outputs 'Hello' and returns nil

# hello = Hello.new
# hello.bye # NoMethodError

# hello = Hello.new
# hello.greet # ArgumentError

# hello = Hello.new
# hello.greet("Goodbye") # outputs 'Goodbye' and returns nil

# Hello.hi

## Question 2

# class Greeting
#   def self.greet(message)
#     puts message
#   end
# end

# class Hello < Greeting
#   def self.hi
#     greet("Hello")
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end

# Hello.hi

## Question 3

# class AngryCat
#   def initialize(age, name)
#     @age  = age
#     @name = name
#   end

#   def age
#     puts @age
#   end

#   def name
#     puts @name
#   end

#   def hiss
#     puts "Hisssss!!!"
#   end
# end

# fluffy = AngryCat.new(2, 'Fluffy')
# snowflake = AngryCat.new(1, 'Snowflake')

## Question 4

# class Cat
#   attr_reader :type

#   def initialize(type)
#     @type = type
#   end

#   def to_s
#     "I am a #{type} cat"
#   end
# end

# kitty = Cat.new('tabby')
# puts kitty

## Question 5

# class Television
#   def self.manufacturer
#     # method logic
#   end

#   def model
#     # method logic
#   end
# end

# tv = Television.new
# tv.manufacturer # NoMethod Error
# tv.model

# Television.manufacturer
# Television.model # NoMethod Error

## Question 6

# class Cat
#   attr_accessor :type, :age

#   def initialize(type)
#     @type = type
#     @age  = 0
#   end

#   def make_one_year_older
#     @age += 1
#   end
# end

# fluffy = Cat.new('tabby')
# fluffy.make_one_year_older
# p fluffy.age

## Question 7

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    "I want to turn on the light with a brightness level of super high and a color of green"
  end

end

p Light.information

## Question 8


## Question 9


