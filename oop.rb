
# ### THE OBJECT MODEL

# module Sound
#   def sound(sound)
#     puts sound
#   end
# end

# class Vehicle
#   include Sound
# end

# car = Vehicle.new
# car.sound('beep-beep')
# truck = Vehicle.new
# truck.sound('honk-honk')

# ### CLASSES AND OBJECTS I

# class Course
#   attr_accessor :course_title, :participants, :date

#   def initialize(course_title)
#     @course_title = course_title
#   end

#   def change_course_info(title, students, date_time)
#     self.course_title = title
#     self.participants = students
#     self.date  = date_time
#   end

#   def notification
#     "The course title is #{self.course_title}, with max #{self.participants} at #{self.date}"
#   end

# end

# course = Course.new('OOP')
# puts course.course_title
# puts course.notification
# course.course_title = 'OOP in Ruby'
# puts course.course_title
# puts course.notification

# course.change_course_info('OOP in JS', 100, '20-09-2020, 15:00')
# puts course.notification

# class MyCar
#   attr_accessor :color
#   attr_reader :year

#   def initialize(year, color, model)
#     @year = year
#     @color = color
#     @model = model
#     @speed = 0
#   end

#   def speed_up(new_speed)
#     @speed += new_speed
#     puts "Your speed increased by #{new_speed} km/h"
#   end

#     def break(new_speed)
#     @speed -= new_speed
#     puts "Your speed decreased by #{new_speed} km/h"
#   end

#   def current_speed
#     puts "You are now going #{@speed} km/h"
#   end

#   def change_color(new_color)
#     self.color = new_color
#     puts "The color now is #{@color}"
#   end

#   def self.calculate_mileage(kilometers, liters)
#     puts "#{kilometers / liters} kilometers per liter of gas"
#   end

#   def to_s
#     "My car is a #{color}, #{year}, #{@model}!"
#   end

# end

# tesla = MyCar.new(2020, 'white', 'S')
# tesla.current_speed
# tesla.speed_up(100)
# tesla.current_speed
# tesla.break(20)
# tesla.current_speed
# p tesla.color
# p tesla.color = 'red'
# p tesla.color
# tesla.change_color('black')
# p tesla.year
# p MyCar.calculate_mileage(100, 2)

# # ### CLASSES AND OBJECTS II

# class Coffee
#   @@number_of_coffees = 0

#   def initialize
#     @@number_of_coffees += 1
#     'test'
#   end

#   def self.total_number_of_coffees
#     @@number_of_coffees
#   end
# end

# puts Coffee.total_number_of_coffees

# cup1 = Coffee.new
# cup2 = Coffee.new
# espresso = Coffee.new

# puts Coffee.total_number_of_coffees

# puts espresso

## INHERITANCE

module Towable
  def can_tow?(kilos)
    pounds < 900 ? true : false
  end
end

class Vehicle

  @@number_of_vehicles = 0

  def self.total_number_of_vehicles
    @@number_of_vehicles += 1
  end

  def self.calculate_mileage(kilometers, liters)
    puts "#{kilometers / liters} kilometers per liter of gas"
  end
end 

class MyCar < Vehicle
  MAX_SPEED = 120
end

class Truck < Vehicle
  include Towable

  MAX_SPEED = 90
end

puts Vehicle.ancestors
puts Truck.ancestors
puts MyCar.ancestors