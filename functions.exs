sum = fn(a, b) -> a + b end
minus = fn(a, b) -> a - b end
calc = fn(f, a, b) -> f.(a, b) end

IO.puts "SUM: #{sum.(1, 3)}"
IO.puts "MINUS: #{minus.(10, 3)}"
IO.puts "CALC SUM: #{calc.(sum, 10, 4)}"
IO.puts "CALC MINUS: #{calc.(minus, 10, 4)}"
