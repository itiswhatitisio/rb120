## Question 1

# true - Boolean
# "hello" - String
# [1, 2, 3, "happy days"] - Array
# 142 - Integer
# use #class method to find out the class of the object

## Question 2

# module Speed
#   def go_fast
#     puts "I am a #{self.class} and going super fast!"
#   end
# end

# class Car
#   include Speed
#   def go_slow
#     puts "I am safe and driving slow."
#   end
# end

# class Truck
#   include Speed
#   def go_very_slow
#     puts "I am a heavy truck and like going very slow."
#   end
# end

# tesla = Car.new
# p tesla.go_fast
# roborock = Truck.new
# p roborock.go_fast

## Question 3

# module Speed
#   def go_fast
#     puts "I am a #{self.class} and going super fast!"
#   end
# end

# class Car
#   include Speed
#   def go_slow
#     puts "I am safe and driving slow."
#   end
# end

## Question 4

# class AngryCat
#   def hiss
#     puts "Hisssss!!!"
#   end
# end

# fluffy = AngryCat.new

## Question 5

# class Fruit
#   def initialize(name)
#     name = name
#   end
# end

# class Pizza
#   def initialize(name)
#     @name = name # instance variables are prefixed with @
#   end
# end

## Question 6

# class Cube
#   attr_reader :volume

#   def initialize(volume)
#     @volume = volume
#   end
# end

## Question 8

# class Cat
#   attr_accessor :type, :age

#   def initialize(type)
#     @type = type
#     @age  = 0
#   end

#   def make_one_year_older
#     self.age += 1 # refers to the calling object
#   end
# end

## Question 9

# class Cat
#   @@cats_count = 0

#   def initialize(type)
#     @type = type
#     @age  = 0
#     @@cats_count += 1
#   end

#   def self.cats_count # refers to the class
#     @@cats_count
#   end
# end

## Question 10

# class Bag
#   def initialize(color, material) #initialize method is expecting two arguments
#     @color = color
#     @material = material
#   end
# end

# tote_bag = Bag.new('white', 'cotton')

# p Bag.new("green", "paper")