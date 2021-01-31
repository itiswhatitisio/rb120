require "io/console"

class Move
  attr_accessor :value
  VALUES = %w(r p s)

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 's'
  end

  def rock?
    @value == 'r'
  end

  def paper?
    @value == 'p'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
    (paper? && other_move.rock?) ||
    (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
    (paper? && other_move.scissors?) ||
    (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end

end

class Player

  attr_accessor :move, :name, :all_moves

  def initialize
    @move = nil
    set_name
    @all_moves = []
  end

  def human?
    @player_type == :human
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

  def choose
    choice = nil
    loop do
      puts "Please choose rock (r), paper (p), or scissors (s):"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice. The choice must be r, p, or s"
    end
      self.move = Move.new(choice)
      @all_moves << choice
    end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Monster', 'Chappie', 'Hal', '42'].sample
  end

  def choose
    mv = Move.new(Move::VALUES.sample)
    self.move = mv
    @all_moves << move.value
  end
end

class RPSGame
  MAX_SCORE = 3

  attr_accessor :human, :computer, :score, :game_count, :round_count

  def initialize
    @human = Human.new
    @computer = Computer.new
    @score = {@human.name => 0, @computer.name => 0}
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def reset_score
    @score = {@human.name => 0, @computer.name => 0}
  end

  def increment_score
    score[human.name] += 1 if determine_winner == human.name
    score[computer.name] += 1 if determine_winner == computer.name
  end

  def display_score
    puts "Scores for this round:"
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

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def determine_winner
    if human.move > computer.move
      human.name
    elsif human.move < computer.move
      computer.name
    else
      :tie
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
   puts "The grand winner is #{score.key(MAX_SCORE)}"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good Bye!"
  end

  def continue
    puts "Press any key to continue"
    STDIN.getch
  end

  def play
   display_welcome_message
   game_count = 0
    loop do
      game_count += 1
      round_count = 0
      loop do
        round_count += 1
        puts "ROUND #{round_count}"
        puts "#{human.name} moves: #{human.all_moves}"
        puts "#{computer.name} moves: #{computer.all_moves}"
        human.choose
        computer.choose
        display_moves
        display_round_winner
        increment_score
        display_score
        break if score.values.include?(MAX_SCORE)
        continue
        #clear_screen
    end
    puts game_count
    puts round_count
      display_grand_winner
      reset_score
      break unless play_again?
    end
    display_goodbye_message
  end
end

game = RPSGame.new
game.play