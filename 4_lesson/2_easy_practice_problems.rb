## Question 1

# class Oracle
#   def predict_the_future
#     "You will " + choices.sample
#   end

#   def choices
#     ["eat a nice lunch", "take a nap soon", "stay at work late"]
#   end
# end

# oracle = Oracle.new
# oracle.predict_the_future

## Question 

# class Oracle
#   def predict_the_future
#     "You will " + choices.sample
#   end

#   def choices
#     ["eat a nice lunch", "take a nap soon", "stay at work late"]
#   end
# end

# class RoadTrip < Oracle
#   def choose
#     ["visit Vegas", "fly to Fiji", "romp in Rome"]
#   end
# end

# trip = RoadTrip.new
# p trip.predict_the_future
# p trip.class.ancestors

## Question 3

# module Taste
#   def flavor(flavor)
#     puts "#{flavor}"
#   end
# end

# class Orange
#   include Taste
# end

# class HotSauce
#   include Taste
# end

# p Orange.ancestors
# p HotSauce.ancestors


## Question 4

# class BeesWax
# attr_accessor :type

#   def initialize(type)
#     @type = type
#   end

#   def describe_type
#     puts "I am a #{type} of Bees Wax"
#   end
# end

## Question 5

# excited_dog = "excited dog" # local variable
# @excited_dog = "excited dog" # instance variable
# @@excited_dog = "excited dog" # class variable

## Question 6

# class Television
#   def self.manufacturer # class method, prefixed by self
#     # method logic
#   end

#   def model
#     # method logic
#   end
# end

# Television.manufacturer

## Question 7

# class Cat
#   @@cats_count = 0

#   def initialize(type)
#     @type = type
#     @age  = 0
#     @@cats_count += 1
#   end

#   def self.cats_count
#     @@cats_count
#   end
# end

# fluffy = Cat.new('siamese')
# cat = Cat.new('british shorthair')
# paws = Cat.new('abyssinian')
# p Cat.cats_count

## Question 8

# class Game
#   def play
#     "Start the game!"
#   end
# end

# class Bingo < Game
#   def rules_of_play
#     #rules of play
#   end
# end

# game_of_bingo = Bingo.new
# game_of_bingo.play

## Question 9

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end

  def play
    "Start Bingo!"
  end
end

new_bingo_game = Bingo.new
p new_bingo_game.play # first coome, first serve
