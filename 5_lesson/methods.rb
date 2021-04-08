
class Human
  attr_accessor :human_marker

  def initialize
    @human_marker
  end

  def choose_marker
     "Please choose your marker"
  end
end

bon = Human.new
puts bon.choose_marker