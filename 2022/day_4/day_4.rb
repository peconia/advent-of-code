# frozen_string_literal: true

input = File.read(File.join(__dir__, 'input.txt'))

pairs = input.split("\n").map do |pair|
  pair.split(',').map { |values| values.split('-').map(&:to_i) }
end

result = pairs.reduce(0) do |total, pair|
  if (pair[0][0] <= pair[1][0] && pair[0][1] >= pair[1][1]) || (pair[1][0] <= pair[0][0] && pair[1][1] >= pair[0][1])
    total += 1
  end
  total
end

puts "Result part 1 is: #{result}"

result_2 = pairs.reduce(0) do |total, pair|
  if (pair[0][1] >= pair[1][0] && pair[0][0] <= pair[1][1]) || (pair[1][1] >= pair[0][0] && pair[1][0] <= pair[0][1])
    total += 1
  end
  total
end

puts "Result part 2 is: #{result_2}"
