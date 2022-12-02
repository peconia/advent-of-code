input = File.read(File.join(__dir__, 'input.txt'))

input = input.split("\n\n").map do |load|
  load.split("\n")
end

input = input.map do |part|
  res = part.map { |s| s.to_i }
  res.sum
end

result = input.max

result_2 = input.max(3).sum

puts "Result part 1 is: #{result}"

puts "Result part 2 is: #{result_2}"
