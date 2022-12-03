input = File.read(File.join(__dir__, 'input.txt'))

rucksacks = input.split("\n").map do |rucksack|
  [rucksack[0, rucksack.size / 2], rucksack[rucksack.size / 2..]]
end

def calculate_total(letters)
  letters.map { |bag| bag[0].swapcase.ord - (bag[0] == bag[0].downcase ? 64 : 70) }
end

rucksacks = rucksacks.map { |rucksack| rucksack[0].each_char.select { |c| rucksack[1].include?(c) } }
result = calculate_total(rucksacks).sum

puts "Result part 1 is: #{result}"

groups = input.split("\n").each_slice(3).to_a.map do |group|
  group[0].each_char.select { |c| group[1].include?(c) && group[2].include?(c) }
end

result_2 = calculate_total(groups).sum

puts "Result part 2 is: #{result_2}"
