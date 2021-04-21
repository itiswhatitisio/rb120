require 'pry'

class Deck
  attr_accessor :new_deck
  
  CARD_VALUES = { 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7,
      8 => 8, 9 => 9, 10 => 10, 'J' => 10, 'Q' => 10, 'K' => 10 }
  ACE_VALUES = [ 1, 11 ]
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
  attr_accessor :cards

  def initialize
    @cards = []
    @score = 0
  end

  def calculate_score
    ranks = []
    aces = []
    cards.each do |card|
      ranks << card[:rank] if card[:rank] != 'A'
      aces << card[:rank] if card[:rank] == 'A'
      end
      sum = ranks.reduce(0) do |sum, rank|
        sum + Deck::CARD_VALUES[rank]
      end
      sum
      aces.each do |ace|
        if sum > 21
          sum += 1
        elsif sum < 21
          sum += 11
          if sum > 21
            sum -=10
          end
        end
      end
      sum
  end

  def stay

  end

  def bust?
    return true if calculate_score > 21
    false
  end
end

class Player < Participant; end

class Dealer < Participant; end

class Game
attr_accessor :deck, :player, :dealer
  def initialize
    @deck = Deck.new
    @player = Participant.new
    @dealer = Participant.new
    @current_player = @player
  end

  def deal_initial_cards
    player.cards << deck.deal_card
    player.cards << deck.deal_card
    dealer.cards << deck.deal_card
    dealer.cards << deck.deal_card
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
      player_card = ""
    end
    cards.join(', ')
  end

  def show_cards
    puts "Dealer has: #{hide_dealer_cards}"
    puts "You have: #{display_player_cards}"
    puts "Your score is: #{player.calculate_score}"
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

  def player_turn
    puts "It's your turn!"
    answer = nil
    loop do
      answer = hit_or_stay
      participant_hits(player) if answer == 'h'
      show_cards
      break if answer == 's' || player.bust?
    end
  end

  def dealer_hits
    loop do
      participant_hits(dealer)
      break if dealer.calculate_score >= 17
    end
  end

  def dealer_turn
    puts "It's dealer's turn"
    dealer_hits
  end

  def determine_winner

  end

  def play
    deal_initial_cards
    show_cards
    player_turn
    dealer_turn
    determine_winner
  end
end

g = Game.new
g.deal_initial_cards
g.show_cards
g.player_turn
g.dealer_turn

