# frozen_string_literal: true

# part 1
result = File.readlines(File.join(__dir__, 'input.txt')).reduce(0) do |total, line|
  l = line.delete("^0-9")
  total + (l[0] + l[-1, 1]).to_i
end

pp result

# part 2

numbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

result = File.readlines(File.join(__dir__, 'input.txt')).reduce(0) do |total, line|
  to_replace =  line.to_enum(:scan, /(?=(one|two|three|four|five|six|seven|eight|nine))/).map do |m, |
    m
  end

  temp = line
  to_replace.each do |word|
    temp = temp.sub(word, (numbers.find_index(word) + 1).to_s + word[-1, 1] )
  end

  l = temp.delete("^0-9")
  total + (l[0] + l[-1, 1]).to_i
end

pp result

