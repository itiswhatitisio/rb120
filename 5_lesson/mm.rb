
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

MARKERS = { 'Player' => 'O',
            'Computer' => 'X',
            'Initial' => ' ' }

WINNING_SCORE = 5
FIRST_TURN = 'choose'
TURN_OPTIONS = %w(player computer choose)
VALID_CHOICES = %w(y n)

def prompt(msg)
  puts " => #{msg}"
end

# rubocop: disable Metrics/AbcSize
def display_board(brd)
  #system 'clear'
  puts "You're a #{MARKERS['Player']}. Computer is #{MARKERS['Computer']}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |"
  puts ""
end
# rubocop: enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = MARKERS['Initial'] }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |n| brd[n] == MARKERS['Initial'] }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))})"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry that's not a valid choice"
  end
  brd[square] = MARKERS['Player']
end

def alternate_player(current_player)
  if current_player == 'Player'
    'Computer'
  else
    'Player'
  end
end

def place_piece!(brd, current_player)
  if current_player == 'Player'
    player_places_piece!(brd)
  elsif current_player == 'Computer'
    computer_places_piece!(brd)
  end
end

# Base case for minimax method

def evaluate_move(brd)
  if detect_winner(brd) == 'Player'
    return -1
  elsif detect_winner(brd) == 'Computer'
    return 1
  elsif board_full?(brd)
    return 0
  else
    return nil
  end
  nil
end

# Actual minimax - outputs the value of the best possible move

def minimax(brd, player)
  best_move = 0
  best_score = -10000 if player == 'Computer' # maximizing player
  best_score = 10000 if player == 'Player' # minimizing player
  empty_squares(brd).each do |empty_square|
    new_board = brd.dup
    puts "player #{player}"
    new_board[empty_square] = MARKERS[player]
    display_board(new_board)
    puts ""
    puts ""
    if someone_won?(new_board) || board_full?(new_board)
      score_current_move = evaluate_move(new_board)
    else
      score_current_move = minimax(new_board, alternate_player(player))[0]
    end
    puts "score_current_move #{score_current_move}"
    # maximizing player
    puts " 111 player #{player}"
    if player == 'Computer' && score_current_move >= best_score
      best_score = score_current_move
      best_move = empty_square
    # minimizing player
    elsif player == 'Player' && score_current_move <= best_score
      best_score = score_current_move
      best_move = empty_square
    end
    puts "best_score #{best_score}"
    puts "best_move #{best_move}"
  end
  [best_score, best_move]
end

def computer_places_piece!(brd)
  square = if empty_squares(brd).length == 9
             pick_fifth_square(brd)
           else
             minimax(brd, 'Computer')[1]
           end
  brd[square] = MARKERS['Computer']
end

def pick_fifth_square(brd)
  5 if brd[5] == MARKERS['Initial']
end

def pick_first_turn
  choice = ' '
  loop do
    prompt "Who makes the first turn: computer ('c') or player ('p')?"
    choice = gets.chomp.downcase
    break if choice == 'p' || choice == 'c'
    prompt "Please type 'c' for computer or 'p' for player"
  end
  choice == 'p' ? 'Player' : 'Computer'
end

def set_first_player
  return pick_first_turn if FIRST_TURN == 'choose'
  return FIRST_TURN if TURN_OPTIONS.include?(FIRST_TURN)
end

def joinor(arr, separator = ', ', kw = 'or')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.insert(arr.index(arr.last), 'or').join(' ')
  else
    arr1 = []
    arr.each_with_index do |el, i|
      arr1 << el.to_s + separator.to_s if i != arr.length - 1
      arr1 << "#{kw} " + el.to_s if i == arr.length - 1
    end
    arr1.join
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(MARKERS['Player']) == 3
      return 'Player'
    elsif brd.values_at(*line).count(MARKERS['Computer']) == 3
      return 'Computer'
    end
  end
  nil
end

def update_score(score, board)
  if detect_winner(board) == 'Player'
    score['Player'] += 1
  elsif detect_winner(board) == 'Computer'
    score['Computer'] += 1
  end
end

def display_score(score)
  prompt "Score: Computer #{score['Computer']}, Player #{score['Player']}"
end

def display_round_winner(board)
  if detect_winner(board) == 'Player'
    prompt 'Player won this round!'
  elsif detect_winner(board) == 'Computer'
    prompt 'Computer won this round!'
  else
    prompt "It's a tie!"
  end
end

def determine_grand_winner(score)
  score.select do |player, individual_score|
    return player if individual_score == WINNING_SCORE
  end
  nil
end

def display_grand_winner(player)
  prompt "The grand winner is #{player}!"
end

def validate_play_one_round
  loop do
    prompt 'Play one more round? (y or n)'
    choice = gets.chomp.downcase
    return choice if VALID_CHOICES.include?(choice)
    prompt 'Please enter y (yes) or n (no)'
  end
end

# Main program

prompt 'Welcome to Tic Tac Toe!'

loop do
  answer_play_round = ''
  score = {
    'Computer' => 0,
    'Player' => 0
  }

  prompt 'Win a match (5 rounds) to become a Grand Winner!'
  prompt 'The game will start in 4 seconds!'
  sleep(4)
  #system 'clear'

  loop do
    #system 'clear'
    board = initialize_board
    current_player = set_first_player

    loop do
      display_board(board)
      display_score(score)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)
    update_score(score, board)
    display_score(score)
    display_round_winner(board)
    break if determine_grand_winner(score)

    answer_play_round = validate_play_one_round

    break if answer_play_round.downcase.start_with?('n')
    prompt 'Next round will start in 2 seconds!'
    sleep(2)

  end

  break if answer_play_round.downcase.start_with?('n')
  display_grand_winner(determine_grand_winner(score))
  prompt 'Play one more match (5 rounds)? (y or n)'
  answer_play_grand_winner = gets.chomp
  break if answer_play_grand_winner.downcase.start_with?('n')
end

prompt 'Thanks for playing Tic Tac Toe! Good bye!'