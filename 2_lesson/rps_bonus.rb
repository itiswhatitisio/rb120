require "io/console"

class Move
  VALUES = { 'r' => 'rock', 'p' => 'paper', 's' => 'scissors',
             'sp' => 'spock', 'l' => 'lizard' }

  attr_accessor :value, :winning_combinations

  def >(other_move)
    winning_combinations.include?(other_move.value)
  end
end

class Rock < Move
  attr_accessor :name, :winning_combinations

  def initialize
    @value = 'rock'
    @winning_combinations = ['scissors', 'lizard']
  end
end

class Paper < Move
  attr_accessor :name, :winning_combinations

  def initialize
    @value = 'paper'
    @winning_combinations = ['rock', 'spock']
  end
end

class Scissors < Move
  attr_accessor :name, :winning_combinations

  def initialize
    @value = 'scissors'
    @winning_combinations = ['paper', 'lizard']
  end
end

class Spock < Move
  attr_accessor :name, :winning_combinations

  def initialize
    @value = 'spock'
    @winning_combinations = ['scissors', 'rock']
  end
end

class Lizard < Move
  attr_accessor :name, :winning_combinations

  def initialize
    @value = 'lizard'
    @winning_combinations = ['paper', 'spock']
  end
end

class Player
  attr_accessor :move, :name, :all_moves, :value

  def initialize
    @move = nil
    set_name
    @all_moves = []
  end

  def human?
    @player_type == :human
  end

  def count_moves
    moves = {}
    all_moves.each do |player_move|
      if moves.keys.include?(player_move)
        moves[player_move] += 1
      else
        moves[player_move] = 1
      end
    end
    moves
  end

  def display_moves_history
    puts "#{name}:"
    count_moves.each_pair do |choice, frequency|
      puts "#{choice} - #{frequency} time(s)"
    end
  end

  def allowed_choices(value)
    case value
    when 'rock' then Rock.new
    when 'scissors' then Scissors.new
    when 'paper' then Paper.new
    when 'spock' then Spock.new
    when 'lizard' then Lizard.new
    end
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    self.name = n
  end

  def valid_input?(choice)
    return true if Move::VALUES.keys.include?(choice)
    puts "Sorry, invalid choice."
  end

  def choose
    choice = nil
    loop do
      puts "Please choose (r)ock, (p)aper, (s)cissors, (l)izard, or (sp)ock:"
      choice = gets.chomp
      break if valid_input?(choice)
    end
    choice = Move::VALUES[choice]
    mv = allowed_choices(choice)
    all_moves << mv.value
    self.move = mv
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Monster', 'Chappie', 'Hal', '42'].sample
  end

  def choose
    mv = allowed_choices(Move::VALUES[Move::VALUES.keys.sample])
    all_moves << mv.value
    self.move = mv
  end
end

class RPSGame
  MAX_SCORE = 10

  attr_accessor :human, :computer, :score, :game_count, :round_count

  def initialize
    @human = Human.new
    @computer = Computer.new
    @score = { @human.name => 0, @computer.name => 0 }
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def reset_score
    @score = { @human.name => 0, @computer.name => 0 }
  end

  def increment_score
    score[human.name] += 1 if determine_winner == human.name
    score[computer.name] += 1 if determine_winner == computer.name
  end

  def display_score
    puts "------------------------"
    puts "Total scores:"
    puts "#{human.name}: #{score[human.name]}"
    puts "#{computer.name}: #{score[computer.name]}"
  end

  def display_welcome_message
    puts "Hi #{human.name}! Welcome to the Rock, Paper, Scissors game!"
    puts "The first one who wins #{MAX_SCORE} games becomes the Grand Winner!"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, invalid input. Must be y or n"
    end

    return false if answer == 'n'
    return true if answer == 'y'
  end

  def players_choose
    human.choose
    computer.choose
  end

  def display_moves
    puts "#{human.name} chose #{human.move.value}"
    puts "#{computer.name} chose #{computer.move.value}"
  end

  def display_players_moves_history
    display_separator_moves_history
    human.display_moves_history
    computer.display_moves_history
  end

  def determine_winner
    if (human.move.value == computer.move.value)
      :tie
    elsif human.move > computer.move
      human.name
    else
      computer.name
    end
  end

  def display_round_winner
    if determine_winner != :tie
      puts "#{determine_winner} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_grand_winner
    puts "------------------------"
    puts "The grand winner is #{score.key(MAX_SCORE)}"
    puts "------------------------"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good Bye!"
  end

  def continue
    puts "Press any key to continue"
    STDIN.getch
    clear_screen
  end

  def display_separator_moves_history
    puts "------------------------"
    puts "Moves History"
  end

  def play_single_round
    loop do
      players_choose
      display_moves
      display_round_winner
      increment_score
      display_score
      display_players_moves_history
      break if score.values.include?(MAX_SCORE)
      continue
    end
  end

  def play
    display_welcome_message
    loop do
      play_single_round
      display_grand_winner
      reset_score
      break unless play_again?
    end
    display_goodbye_message
  end
end

game = RPSGame.new
game.play
