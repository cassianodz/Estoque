# you can write to stdout for debugging purposes, e.g.
# puts "this is a debug message"

def solution(message, k)
  counter = 10
  nota = true
  p nota
  while nota
    p counter
    counter = counter - 1
    nota == counter > 2
  end
end

solution(1,2)
