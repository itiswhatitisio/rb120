require 'io/console'

class Deck
  attr_accessor :new_deck

  CARD_VALUES = { 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7,
                  8 => 8, 9 => 9, 10 => 10, 'J' => 10, 'Q' => 10, 'K' => 10 }
  ACE_VALUES = { low: 1, high: 11 }
  RANKS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']

  SUITS = ['♣', '♦', '♥', '♠']

  def initialize
    @new_deck = generate_new_deck
  end

  def generate_new_deck
    deck = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        deck << { suit: suit, rank: rank }
      end
    end
    deck
  end

  def deal_card
    card = new_deck.sample
    new_deck.delete(card)
    card
  end
end

class Participant
  attr_reader :name
  attr_accessor :cards, :score, :deck

  def initialize(name)
    @cards = []
    @score = 0
    @name = name
  end

  def calculate_score
    ranks = []
    aces = []
    cards.each do |card|
      ranks << card[:rank] if card[:rank] != 'A'
      aces << card[:rank] if card[:rank] == 'A'
    end
    @score = ranks.reduce(0) do |sum, rank|
      sum + Deck::CARD_VALUES[rank]
    end
    calculate_aces_value(aces)
  end

  def calculate_aces_value(aces)
    aces.each do |_|
      if @score > 21
        @score += 1
      elsif @score < 21
        @score += 11
        @score -= 10 if @score > 21
      end
    end
  end

  def reset_score
    self.score = 0
  end

  def reset_cards
    self.cards = []
  end

  def busteded?
    return true if score > 21
    false
  end
end

class Player < Participant
  attr_accessor :name, :cards

  def initialize
    @name = set_name
    super(name)
  end

  def set_name
    answer = nil
    puts "Please choose your name"
    puts "The name must consist of any alphabetical characters (A-Z and a-z)"
    loop do
      answer = gets.chomp
      break if valid_name?(answer)
      puts "This is not a valid name"
    end
    puts "Your name is #{answer}"
    self.name = answer
  end

  def valid_name?(answer)
    answer.match?(/\A[a-zA-Z'-]*\z/)
  end
end

class Game
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Participant.new("Dealer")
    @current_player = @player
  end

  def play_one_round(end_of_round: true)
    loop do
      deal_initial_cards
      player_turn
      break if player.busted?
      dealer_turn
      break if dealer.busted?
      determine_winner 
      break if end_of_round
    end
  end

  def play
    display_welcome_message
    loop do
      play_one_round
      reset_cards_and_score
      break if quit_game?
    end
    display_goodby_message
  end

  private

  def display_welcome_message
    puts ""
    puts "Welcome to Twenty One Game, #{player.name}!"
    puts "You well be playing against #{dealer.name}"
    puts ""
    puts "The goal of the game is to get to 21 as close as possible"
    puts "If the sum of your cards is more than 21, you loose"
    puts "Good luck!"
    puts ""
    continue
  end

  def continue
    puts "Press any key to continue..."
    $stdin.getch
    clear_screen
  end

  def clear_screen
    system 'clear'
  end

  def deal_initial_cards
    2.times do
      player.cards << deck.deal_card
      dealer.cards << deck.deal_card
    end
  end

  def hide_dealer_cards
    dealer_card = dealer.cards[0]
    "#{dealer_card[:suit]}#{dealer_card[:rank]} and an uknown card"
  end

  def display_player_cards
    cards = []
    player.cards.each do |card|
      player_card = ""
      player_card << card[:suit]
      player_card << card[:rank].to_s
      cards << player_card
    end
    cards.join(', ')
  end

  def show_cards
    puts "Dealer has: #{hide_dealer_cards}"
    puts "You have: #{display_player_cards}"
    player.calculate_score
    puts "Your score is: #{player.score}"
  end

  def hit_or_stay
    answer = nil
    loop do
      puts "(H)it or (s)tay?"
      answer = gets.chomp
      break if answer == 'h' || answer == 's'
    end
    answer
  end

  def participant_hits(participant)
    participant.cards << deck.deal_card
  end

  def clear_screen_and_display_cards
    clear_screen
    show_cards
  end

  def player_turn
    clear_screen_and_display_cards
    puts "It's your turn!"
    answer = nil
    loop do
      answer = hit_or_stay
      participant_hits(player) if answer == 'h'
      clear_screen_and_display_cards
      break if answer == 's' || player.busted?
    end
  end

  def dealer_turn
    puts "It's dealer's turn"
    loop do
      break if dealer.score >= 17
      participant_hits(dealer)
      dealer.calculate_score
      break if dealer.score >= 17
    end
    puts "Dealer score is #{dealer.score}"
    puts "Dealer loses!" if dealer.busted?
  end

  def determine_winner
    if dealer.score > player.score
      puts "Dealer wins"
    elsif player.score > dealer.score
      puts "You win"
    else
      puts "It's a tie"
    end
  end

  def quit_game?
    answer = nil
    loop do
      puts "Would you like to play another round?"
      answer = gets.chomp
      break if answer == 'n' || answer == 'y'
    end
    answer == 'n'
  end

  def reset_cards_and_score
    player.reset_score
    player.reset_cards
    dealer.reset_score
    dealer.reset_cards
  end

  def display_goodby_message
    puts "Thank you for playing!"
  end
end

twenty_one = Game.new
twenty_one.play
