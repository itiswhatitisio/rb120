require "io/console"

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end

  def mark; end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = HUMAN_MARKER
  WINNING_SCORE = 2
  attr_reader :board, :human, :computer
  attr_accessor :score

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
    @score = { human: 0, computer: 0 }
  end

  def play
    display_welcome_message
    loop do
      play_for_grand_winner
      display_grand_winner
      display_play_again_message
      break unless play_again?
      reset
      reset_score
    end
    display_goodbye_message
  end

  private

  def play_one_round
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      display_board_and_clear_screen if human_turn?
    end
  end

  def play_for_grand_winner
    loop do
      display_board
      play_one_round
      display_result
      calculate_score
      display_score
      continue
      reset
      break if score.values.include?(WINNING_SCORE)
    end
  end

  def continue
    puts "Press any key to continue"
    $stdin.getch
    clear_screen
  end

  def joinor(choices, separator=', ', conjunction='or')
    case choices.length
    when 0
      ''
    when 1
      choices.first
    when 2
      choices.insert(1, conjunction).join(' ')
    else
      add_conjunction(choices, separator, conjunction)
    end
  end

  def add_conjunction(choices, separator =',', conjunction='or')
    new_choices = []
    choices.each_with_index do |choice, index|
      new_choices << "#{choice}#{separator}" if index != choices.length - 1
      new_choices << "#{conjunction} #{choice}" if index == choices.length - 1
    end
    new_choices.join
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice"
    end

    board.[]=(square, human.marker)
  end

  def computer_moves
    board.[]=((board.unmarked_keys.sample), computer.marker)
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts "The first player to win #{WINNING_SCORE} games is Grand Winner!"
    puts " "
  end

  def display_goodbye_message
    puts "Thank you for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def display_board
    puts "You're a #{human.marker}. Computer is #{computer.marker}"
    puts ""
    board.draw
    puts ""
  end

  def display_board_and_clear_screen(clear: true)
    clear_screen if clear
    display_board
  end

  def display_result
    display_board_and_clear_screen

    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def calculate_score
    case board.winning_marker
    when human.marker
      @score[:human] += 1
    else
      @score[:computer] += 1
    end
  end

  def determine_grand_winner
    score.key(WINNING_SCORE)
  end

  def reset_score
    @score = { human: 0, computer: 0 }
  end

  def display_score
    puts "** SCORES **"
    puts "Computer: #{@score[:computer]}"
    puts "Player: #{@score[:human]}"
  end

  def display_grand_winner
    if score.key(WINNING_SCORE) == :human
      puts "You are the Grand Winner!"
    else
      puts "Computer is the Grand Winner!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear_screen
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def current_player_moves
    if @current_marker == HUMAN_MARKER
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end
end

game = TTTGame.new
game.play
