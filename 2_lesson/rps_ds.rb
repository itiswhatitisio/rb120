moves_history = {'ruby'=>[]}


game_count = 0
loop do
  game_count += 1
  round_count = 0
  moves_history['ruby'][game_count - 1] = {:game_count => game_count, :rounds => []}
  loop do
    round_count +=1 
    choice = ['r','p','s'].sample
    p moves_history
p moves_history
moves_history['ruby'][game_count - 1][:rounds] << {:round_count => round_count}
p moves_history
moves_history['ruby'][game_count - 1][:rounds][round_count - 1][:moves] = []
p moves_history
moves_history['ruby'][game_count - 1][:rounds][round_count - 1][:moves] << choice
p moves_history
 break if round_count == 2
 end
 break if game_count == 3
end

puts moves_history

