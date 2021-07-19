
class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7,
                  8 => 8, 9 => 9, 10 => 10, 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    VALUES.fetch(rank, rank)
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

# Include Card and Deck classes from the last two exercises.

class PokerHand
  attr_accessor :poker_hand

  def initialize(hand)
    @poker_hand = hand
  end

  def print
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  #private

  def royal_flush?
    ranks = []
    suits = []
    poker_hand.each do |card|
      ranks << Card::VALUES[card.rank]
      suits << card.suit
    end
    ranks.sort!
    (ranks == [10, 11, 12, 13, 14]) && (suits.uniq.length == 1)
  end

  def straight_flush?
    ranks = []
    suits = []
    poker_hand.each do |card|
      ranks << Card::VALUES[card.rank]
      suits << card.suit
    end
    ranks.sort!
    ((ranks.last - ranks.first) == 4) && (suits.uniq.length == 1)
  end

  def four_of_a_kind?
    ranks = []
    suits = []
    poker_hand.each do |card|
      ranks << Card::VALUES[card.rank]
      suits << card.suit
    end
    card_counts = ranks.each_with_object(Hash.new(0)) { |el, counts| counts[el] += 1 }
    card_counts.values.sort == [1, 4]
  end

  def full_house?
    ranks = []
    suits = []
    poker_hand.each do |card|
      ranks << Card::VALUES[card.rank]
      suits << card.suit
    end
    card_counts = ranks.each_with_object(Hash.new(0)) { |el, counts| counts[el] += 1 }
    card_counts.values.sort == [2, 3]
  end

  def flush?
    suits = []
    poker_hand.each do |card|
      suits << card.suit
    end
    suits.uniq.length == 1
  end

  def straight?
    ranks = []
    poker_hand.each do |card|
      ranks << Card::VALUES[card.rank]
    end
    consecutive?(ranks.sort!)
  end

  def three_of_a_kind?
    ranks = []
    poker_hand.each do |card|
      ranks << Card::VALUES[card.rank]
    end
    card_counts = ranks.each_with_object(Hash.new(0)) { |el, counts| counts[el] += 1 }
    card_counts.values.include?(3)
  end

  def two_pair?
    ranks = []
    poker_hand.each do |card|
      ranks << Card::VALUES[card.rank]
    end
    card_counts = ranks.each_with_object(Hash.new(0)) { |el, counts| counts[el] += 1 }
    card_counts.values.sort == [1, 2, 2]
  end

  def pair?
    ranks = []
    poker_hand.each do |card|
      ranks << Card::VALUES[card.rank]
    end
    card_counts = ranks.each_with_object(Hash.new(0)) { |el, counts| counts[el] += 1 }
    card_counts.values.include?(2)
  end

  def consecutive?(arr)
  return false unless arr.size == 5
  arr.each_cons(2).all? {|a, b| b == a + 1 }
end
end


# Straight flush: Five cards of the same suit in sequence (if those five are A, K, Q, J, 10; it is a Royal Flush)
# Four of a kind: Four cards of the same rank and any one other card
# Full house: Three cards of one rank and two of another
# Flush: Five cards of the same suit
# Straight: Five cards in sequence (for example, 4, 5, 6, 7, 8)
# Three of a kind: Three cards of the same rank
# Two pair: Two cards of one rank and two cards of another
# One pair: Two cards of the same rank
# High card: If no one has a pair, the highest card wins

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

#Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
p hand.pair?
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'

