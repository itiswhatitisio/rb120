class NumberToGuess
  attr_accessor :number

  def initialize
    @number = random_number
  end

  def random_number
    (1..100).to_a.sample
  end
end

class GuessingGame
  attr_accessor :remaining_guesses, :random_number

  def initialize
    @random_number = NumberToGuess.new
    @remaining_guesses = 7
  end

  def guess
    answer = nil
    loop do
      puts 'Enter a number between 1 and 100'
      answer = gets.chomp.to_i
      break if (1..100).to_a.include?(answer)

      puts 'Invalid guess. Enter a number between 1 and 100.'
    end
    answer
  end

  def check(answer)
    return :low if answer < random_number.number
    return :high if answer > random_number.number

    :correct
  end

  def display(result)
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
      display(check(guess))
      break if check(guess) == :correct

      @remaining_guesses -= 1
      break if @remaining_guesses.zero?
    end
    puts 'You won!' if outcome == :correct
    puts 'You have no more guesses. You lost!'
  end
end

game = GuessingGame.new
game.play
