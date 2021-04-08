require 'io/console'
require 'pry'

class Board
  attr_accessor :squares

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
    @squares.keys.select do |key|
      @squares[key].unmarked?
    end
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

  # rubocop: disable Metrics/MethodLength
  # rubocop: disable Metrics/AbcSize
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
  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Metrics/AbcSize
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
  attr_accessor :name

  def initialize(marker, name)
    @marker = marker
    @name = name
  end

  def mark; end
end

class TTTGame
  attr_reader :computer, :name
  attr_accessor :score, :board, :human

  COMPUTER_MARKER = 'X'
  COMPUTER_NAMES = ['R2D2', 'Apricot', 'Brain', '42']
  WINNING_SCORE = 2

  def initialize
    @board = Board.new
    @human = Player.new(set_marker, set_name)
    @computer = Player.new(COMPUTER_MARKER, COMPUTER_NAMES.sample)
    @score = { human: 0, computer: 0 }
  end

  def play
    display_welcome_message
    first_to_move
    loop do
      play_for_grand_winner
      display_grand_winner if score.values.include?(WINNING_SCORE)
      break if exit_game?
      reset
      reset_score
    end
    display_goodbye_message
  end

  private

  def set_marker
    marker = nil
    puts "Choose one character to be your marker, except for X and space"
    loop do
      marker = gets.chomp
      break if marker != 'X' && marker != ' ' && marker.length == 1
      puts "This is not a valid marker"
    end
    puts "Your marker is #{marker}"
    puts ""
    marker
  end

  def set_name
    name = nil
    puts "Please choose your name"
    puts "The name must consist of any alphabetical characters (A-Z and a-z)"
    loop do
      name = gets.chomp
      break if name.match?(/\A[a-zA-Z'-]*\z/) && !COMPUTER_NAMES.include?(name)
      puts "This is not a valid name"
    end
    puts "Your name is #{name}"
    name
  end

  def first_to_move
    @current_marker = human.marker
  end

  def play_one_round
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      display_board_and_clear_screen if human_turn?
    end
    display_result
    calculate_score
    display_score
  end

  def play_for_grand_winner
    loop do
      display_board
      play_one_round
      reset
      break if score.values.include?(WINNING_SCORE)
      break if exit_round?
      clear_screen
    end
  end

  def exit_game?
    answer = nil
    loop do
      puts "Would you like to exit the game? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def exit_round?
    answer = nil
    loop do
      puts "Would you like to exit the round? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or n"
    end

    answer == 'y'
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
    puts "Choose a square:(#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice"
    end
    board[square] = human.marker
  end

  def computer_moves
    if board.unmarked_keys.length >= 8 && board.squares[5].unmarked?
      board[5] = computer.marker
    else
      board[minimax(@current_marker)[1]] = computer.marker
    end
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
    puts "#{human.name} is #{human.marker}."
    puts "#{computer.name} is #{computer.marker}"
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
    @score[:human] += 1 if board.winning_marker == human.marker
    @score[:computer] += 1 if board.winning_marker == COMPUTER_MARKER
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
      puts "#{human.name} are the Grand Winner!"
    else
      puts "#{computer.name} is the Grand Winner!"
    end
  end

  def play_again?
    display_play_again_message
    answer = nil
    loop do
      puts "Would you like to play for Grand Winner again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def reset
    board.reset
    @current_marker = human.marker
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def current_player_moves
    if @current_marker == human.marker
      human_moves
      @current_marker = COMPUTER_MARKER
    elsif @current_marker == COMPUTER_MARKER
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def evaluate_move
    return -1 if board.winning_marker == human.marker
    return 1 if board.winning_marker == COMPUTER_MARKER
    return 0 if board.full?
  end

  def alternate_player(current_player)
    if current_player == COMPUTER_MARKER
      human.marker
    else
      COMPUTER_MARKER
    end
  end

  def calculate_score_current_move(player)
    if board.someone_won? || board.full?
      evaluate_move
    else
      minimax(alternate_player(player))[0]
    end
  end

  # rubocop: disable Metrics/MethodLength
  # rubocop: disable Metrics/AbcSize
  def minimax(player)
    best_move = 0
    best_score = -10000 if player == COMPUTER_MARKER
    best_score = 10000 if player == human.marker
    board.unmarked_keys.each do |empty_square|
      board[empty_square] = player
      score_current_move = calculate_score_current_move(player)
      if player == COMPUTER_MARKER && score_current_move >= best_score
        best_score = score_current_move
        best_move = empty_square
      elsif player == human.marker && score_current_move <= best_score
        best_score = score_current_move
        best_move = empty_square
      end
      board[empty_square] = Square::INITIAL_MARKER
    end
    [best_score, best_move]
  end
  # rubocop: enable Metrics/MethodLength
  # rubocop: enable Metrics/AbcSize
end

game = TTTGame.new
game.play
