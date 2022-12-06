input = File.read(File.join(__dir__, 'input.txt'))

input = input.split("\n\n").map do |load|
  load.split("\n")
end

crates = input[0].map do |crate|
  (3..crate.size - 1).step(4) { |n| crate[n] = '*' }
  crate.split('*')
end

number_of_piles = crates.pop.length

crates.map do |crate|
  crate.push("   ") while crate.length < number_of_piles
end

piles = crates.reverse.transpose.map do |crate|
  crate.filter { |elem| !elem.strip.empty? }
end

instructions = input[1].map do |instruction|
  instruction.scan(/\d{1,2}/).map(&:to_i)
end

def move_crate(instruction, piles)
  instruction[0].times do
    crate_to_to_move = piles[instruction[1] - 1].pop
    piles[instruction[2] - 1].push(crate_to_to_move)
  end
  piles
end

instructions.each do |instruction|
  piles = move_crate(instruction, piles)
end

result = piles.map do |pile|
  pile.last.chars[1] if pile.last
end

puts "Result part 1 is: #{result.join}"
