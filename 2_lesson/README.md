# Rock-Paper-Scissors Bonus Features

Here I will explain my reasoning behind choices for implementing the RPS Bonus Features.

### 1. Keeping track of Score

An individual game is where we keep track of scores for players. In this context, I created a `@score` attribute in the `RPSGame` class. The `score` attribute is initialized to 0 for both players.

```ruby
class RPSGame
  MAX_SCORE = 3

  attr_accessor :human, :computer, :score, :game_count, :round_count

  def initialize
    @human = Human.new
    @computer = Computer.new
    @score = { @human.name => 0, @computer.name => 0 }
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def reset_score
    @score = { @human.name => 0, @computer.name => 0 }
  end

  def increment_score
    score[human.name] += 1 if determine_winner == human.name
    score[computer.name] += 1 if determine_winner == computer.name
  end

  def display_score
    puts "Scores for this round:"
    puts "#{human.name}: #{score[human.name]}"
    puts "#{computer.name}: #{score[computer.name]}"
  end
```
### 2. Add Lizard and Spock

Initial exploration was to add more condition chechks to the existing methods:

```ruby
def >(other_move)
    (rock? && other_move.scissors?) ||
    (rock? && other_move.lizard?) ||
    (lizard? && other_move.spock?) ||
    (lizard? && other_move.paper?) ||
    (paper? && other_move.spock?) ||
    (paper? && other_move.rock?) ||
    (spock? && other_move.scissors?) ||
    (spock? && other_move.rock?) ||
    (scissors? && other_move.paper?) ||
    (scissors? && other_move.lizard?)
  end

  def <(other_move)
    (scissors? && other_move.rock?) ||
    (lizard? && other_move.rock?) ||
    (spock? && other_move.lizard?) ||
    (paper? && other_move.lizard?) ||
    (spock? && other_move.paper?) ||
    (rock? && other_move.paper?) ||
    (scissors? && other_move.spock?) ||
    (rock? && other_move.spock?) ||
    (spock? && other_move.scissors?) ||
    (rock? && other_move.scissors?)
  end
  ```
This became quite bulky, hard to read, and included some repetion. Creating a separate class for each move became a good solution, as it allowed to have winnig combinations for each move.

```ruby
class Rock < Move
  attr_accessor :name, :winning_combinations

  def initialize
    @value = 'rock'
    @winning_combinations = ['scissors', 'lizard']
  end
end

class Paper < Move
  attr_accessor :name, :winning_combinations

  def initialize
    @value = 'paper'
    @winning_combinations = ['rock', 'spock']
  end
end
```
Due to this design choice, if needed, the game can be expanded with further moves (for example, to create a [RPS-25](https://www.umop.com/rps25.htm)) by adding more classes for each move and defining winning combinations as part of the move's state.

### 3. Add a class for each move
