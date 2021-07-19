class Machine
  def start
    self.flip_switch(:on)
  end

  def stop
    self.flip_switch(:off)
  end

  private

  attr_writer :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

robot = Machine.new
p robot
robot.stop
p robot
robot.start
p robot
robot.switch=(:off)
p robot
robot.flip_switch
p robot