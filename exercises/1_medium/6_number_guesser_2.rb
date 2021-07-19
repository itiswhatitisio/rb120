class NumberToGuess
  attr_accessor :number

  def initialize(range)
    @number = random_number(range)
  end

  def random_number(range)
    range.to_a.sample
  end
end

class GuessingGame
  attr_accessor :remaining_guesses, :random_number

  def initialize(lower_limit, upper_limit)
    @range = (lower_limit..upper_limit)
    @random_number = NumberToGuess.new(@range)
    size_of_range = @range.to_a.size
    @remaining_guesses = Math.log2(size_of_range).to_i + 1
  end

  def guess
    answer = nil
    loop do
      puts "Enter a number between #{@range.first} and #{@range.last}"
      answer = gets.chomp.to_i
      break if @range.to_a.include?(answer)

      puts 'Invalid guess. Enter a number between 1 and 100.'
    end
    answer
  end

  def check(answer)
    return :low if answer < random_number.number
    return :high if answer > random_number.number
    return :correct if answer == random_number.number
  end

  def display_result(result)
    case result
    when :low
      puts 'Your guess is too low.'
    when :high
      puts 'Your guess is too high.'
    else
      puts "That's the number!"
    end
  end

  def play
    outcome = nil
    loop do
      puts "You have #{remaining_guesses} remaining_guesses."
      outcome = check(guess)
      display_result(outcome)
      break if outcome == :correct

      @remaining_guesses -= 1
      break if @remaining_guesses.zero?
    end
    puts 'You won!' if outcome == :correct
    puts 'You have no more guesses. You lost!'
  end
end

game = GuessingGame.new(501, 1500)
game.play
