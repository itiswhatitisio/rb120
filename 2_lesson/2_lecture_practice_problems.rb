# #1
# class Person
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end
# end

# bob = Person.new('bob')
# p bob.name                  # => 'bob'
# bob.name = 'Robert'
# p bob.name                  # => 'Robert'

#2

# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(first_name='', last_name='')
#     @first_name = first_name
#     @last_name = last_name
#   end

#   def name
#     "#{first_name} #{last_name}".strip
#   end
# end

# bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'

#3

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    full_name_splitted = full_name.split
    @first_name = full_name_splitted.first
    @last_name = full_name_splitted.size > 1 ? full_name_splitted.last : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    full_name_splitted = full_name.split
    self.first_name = full_name_splitted.first
    self.last_name = full_name_splitted.size > 1 ? full_name_splitted.last : ''
  end
end

bob = Person.new('Robert')
bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'

# 4

rob = Person.new('Robert Smith')
bob = Person.new('Robert Smith')

p rob === bob

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

# 5
class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    full_name_splitted = full_name.split
    @first_name = full_name_splitted.first
    @last_name = full_name_splitted.size > 1 ? full_name_splitted.last : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    full_name_splitted = full_name.split
    self.first_name = full_name_splitted.first
    self.last_name = full_name_splitted.size > 1 ? full_name_splitted.last : ''
  end

  def to_s
    name
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"