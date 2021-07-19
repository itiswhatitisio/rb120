class CircularQueue
attr_accessor :queue, :start_buffer
  @@object_number = 0

  def initialize(buffer_size)
    @buffer_size = buffer_size - 1
    @queue = Array.new(buffer_size)
    @start_buffer = 0
    @next_position = 0
  end

  def enqueue(element)
    @queue.pop
    @queue.unshift(element)
  end

  def find_index_oldest_element
    @queue.rindex { |el| el != nil }
  end

  def dequeue
    return nil if @queue.all?(nil)
    if @queue.include?(nil)
      element = @queue[find_index_oldest_element]
      @queue[find_index_oldest_element] = nil 
      return element
    else
      element = @queue.pop
      @queue.push(nil)
      return element
    end
  end

end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

=begin
Requirements:
- buffer size to store how many objects can be stored
- method enqueue to add an object to a queue
- method dequeue to remove an object from a queue and return it
- nil is for empty values in the queue

Data stucture/Algorithm:
- array, since we need to have a data structure of a certain size
  - pricinple first in, first out

- method enqueue
  - add an object to a queue
  - if the spot is nil, then add object to this spot
=end