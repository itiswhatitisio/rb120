class Player
  VALID_CHOICES = %w(rock paper scissors)
  attr_accessor :move, :name

  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name
  end

  def set_name
    if human?
      n = ""
      loop do
        puts "What's your name?"
        n = gets.chomp
        break unless n.empty?
        puts "Sorry, must enter a value"
      end
      self.name = n
    else
      self.name = ['R2D2', 'Monster', 'Chappie', 'Hal', '42'].sample
    end
  end

  def choose
    if human?
      choice = nil
      loop do
        puts "Please choose rock, paper, or scissors:"
        choice = gets.chomp
        break if VALID_CHOICES.include?(choice)
        puts "Sorry, invalid choice"
      end
      self.move = choice
    else
      self.move = VALID_CHOICES.sample
    end
  end

  def human?
    @player_type == :human
  end
end


class Move
  def initialize
    # seems like we need something to keep track
    # of the choice... a move object can be "paper", "rock" or "scissors"
  end
end

class Rule
  def initialize
    # not sure what the "state" of a rule object should be
  end
end

# not sure where "compare" goes yet
def compare(move1, move2)

end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new(:human)
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to the Rock, Paper, Scissors game!"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, invalid input. Must be y or n"
    end

    return true if answer == 'y'
    return false
  end

  def display_winner
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"

    case human.move
    when 'rock'
      puts "It's a tie" if computer.move == 'rock'
      puts "#{computer.name} wins!" if computer.move == 'paper'
      puts "#{human.name} wins!" if computer.move == 'scissors'
    when 'paper'
      puts "It's a tie" if computer.move == 'paper'
      puts "#{computer.name} wins!" if computer.move == 'scissors'
      puts "#{human.name} wins!" if computer.move == 'rock'
    when 'scissors'
      puts "It's a tie" if computer.move == 'scissors'
      puts "#{computer.name} wins!" if computer.move == 'rock'
      puts "#{human.name} wins!" if computer.move == 'paper'
    end
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good Bye!"
  end

  def play
    loop do
      display_welcome_message
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

game = RPSGame.new
game.play