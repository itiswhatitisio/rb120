
class Card
  include Comparable
  attr_reader :rank, :suit

  CARD_VALUES = { 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7,
                  8 => 8, 9 => 9, 10 => 10, 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    CARD_VALUES.fetch(rank, rank)
  end

  def <=>(other_card)
    value <=> other_card.value
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  attr_accessor :deck

  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @deck = generate_deck.shuffle
  end

  def generate_deck
    cards = []
    SUITS.each do |suit|
      RANKS.each do |rank|
       cards << Card.new(rank, suit)
      end
    end
    cards
  end

  def draw
    card = deck.pop
    deck.shuffle
    if deck.empty?
      @deck = generate_deck
    end
    card
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.

