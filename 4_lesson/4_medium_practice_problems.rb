## Question 1

# class BankAccount
#   attr_reader :balance

#   def initialize(starting_balance)
#     @balance = starting_balance
#   end

#   def positive_balance?
#     balance >= 0
#   end
# end

# On line 11, we are referring to the #balance getter method
# which is created when we add attr_reader :balance on line 4
# Ben is right

# # Question 2

# class InvoiceEntry
#   attr_reader :product_name
#   attr_accessor :quantity

#   def initialize(product_name, number_purchased)
#     @quantity = number_purchased
#     @product_name = product_name
#   end

#   def update_quantity(updated_count)
#     # prevent negative quantities from being set
#     self.quantity = updated_count if updated_count >= 0
#   end
# end

# prod = InvoiceEntry.new('apple', 1)
# prod.update_quantity(10)
# p prod.quantity

# # Here we need to use self inside of the instance method
# # to help Ruby to distinguish between a method and a local varibale
# # Without self. Ruby will consider this as a local variable

## Question 3

# class InvoiceEntry
#   attr_reader :product_name
#   attr_accessor :quantity

#   def initialize(product_name, number_purchased)
#     @quantity = number_purchased
#     @product_name = product_name
#   end

#   def update_quantity(updated_count)
#     self.quantity = updated_count if updated_count >= 0
#   end
# end

# prod = InvoiceEntry.new('apple', 1)
# prod.update_quantity(10)
# p prod.quantity = 20
# p prod.quantity

# Question 4

# class Greeting
#   def greet(message)
#     puts "#{message}"
#   end
# end

# class Hello < Greeting
#   def hi
#     greet("Hello")
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet('Goodbye')
#   end
# end

# greeting1 = Hello.new
# greeting1.hi

# greeting2 = Goodbye.new
# greeting2.bye

# Question 5

# class KrispyKreme
#   attr_accessor :filling_type, :glazing

#   def initialize(filling_type, glazing)
#     @filling_type = filling_type
#     @glazing = glazing
#   end

  # def to_s
  #   "Plain" if filling_type == nil && glazing == nil
  #   "#{filling_type}" if filling_type != nil && glazing == nil
  #   "Plain with #{glazing}" if filling_type == nil && glazing != nil
  #   "#{filling_type} with #{glazing}" if filling_type != nil && glazing != nil
  # end

#   def to_s
#     filling_string = @filling_type ? @filling_type : "Plain" # ternary operator with assignment
#     glazing_string = @glazing ? " with #{@glazing}" : ''
#     filling_string + glazing_string
#   end
# end

# #donut1 = KrispyKreme.new(nil, nil)
# donut2 = KrispyKreme.new("Vanilla", nil)
# donut3 = KrispyKreme.new(nil, "sugar")
# donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
# donut5 = KrispyKreme.new("Custard", "icing")

# # puts donut1
#   # => "Plain"

# puts donut2
#   # => "Vanilla"

# puts donut3
#   # => "Plain with sugar"

# puts donut4
#   # => "Plain with chocolate sprinkles"

# puts donut5
#   # => "Custard with icing"

# Question 6

# class Computer
#   attr_accessor :template

#   def create_template
#     @template = "template 14231"
#   end

#   def show_template
#     template
#   end
# end

# class Computer
#   attr_accessor :template

#   def create_template
#     self.template = "template 14231"
#   end

#   def show_template
#     self.template # invoking getter method, self is not required
#   end
# end
# Question 7

# class Light
#   attr_accessor :brightness, :color

#   def initialize(brightness, color)
#     @brightness = brightness
#     @color = color
#   end

#   def status
#     "I have a brightness level of #{brightness} and a color of #{color}"
#   end

# end

# bulb = Light.new(100, 'warm white')
# puts bulb.status