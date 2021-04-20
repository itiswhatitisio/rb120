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
    @cards = [{:suit=>"♣", :rank=>"A"}]
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

  def bust?
  end
end

class Player < Participant
  def hit
  end

  def stay
  end
end

class Dealer < Participant
  def hit
  end

  def stay
  end
end

class Game
attr_accessor :deck, :player, :dealer
  def initialize
    @deck = Deck.new
    @player = Participant.new
    @dealer = Participant.new
  end

  def deal_initial_cards
    player.cards << deck.deal_card
    player.cards << deck.deal_card
    dealer.cards << deck.deal_card
    dealer.cards << deck.deal_card
  end

  def play
    #deal_initial_cards
    show_cards
    player_turn
    dealer_turn
    determine_winner
  end
end

g = Game.new
g.deal_initial_cards
p g.player
p g.player.calculate_score

