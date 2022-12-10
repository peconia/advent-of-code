input = File.readlines(File.join(__dir__, 'input.txt')).each.map { |load| load.split(' ') }.map do |line|
  line.length > 1 ? [0, line[1].to_i] : 0
end

instructions = input.flatten
first_20 = instructions.shift(20)
first_cycle = [first_20.sum + 1, first_20.last]
cycles = instructions.each_slice(40).to_a.filter_map { |c| [c.sum, c.last] if c.length == 40 }
all_cycles = cycles.unshift(first_cycle)

result = all_cycles.each_with_index.map do |part, index|
  earlier = all_cycles[0..index].reduce(0) { |sum, value| sum += value[0] }
  (20 + index * 40) * (earlier - all_cycles[index][1])
end

puts "Result part 1 is: #{result.sum}"
