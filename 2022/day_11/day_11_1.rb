# frozen_string_literal: true

input = File.read(File.join(__dir__, 'input.txt')).split("\n\n").map do |load|
  load.split("\n")
end

monkeys = input.each.map do |monkey|
  starting_items = monkey[1].split(/Starting items: /).last.split(', ').map(&:to_i)
  operation = monkey[2].split(/Operation: new = old /).last.split(' ')
  test = monkey[3].split(/divisible by /).last.to_i
  throw_to_if_true = monkey[4].chars.last.to_i
  throw_to_if_false = monkey[5].chars.last.to_i
  [starting_items, operation, test, [throw_to_if_true, throw_to_if_false]]
end

inspections = Array.new(monkeys.count, 0)

def calculate_worry_level(item, operation)
  op = operation[0]
  num = operation[1] == 'old' ? item : operation[1].to_i
  case op
  when '+'
    item += num
  when '*'
    item *= num
  end
  item / 3
end

20.times do |j|
  monkeys.count.times do |i|
    items = monkeys[i][0]
    operation = monkeys[i][1]
    items&.each do |item|
      worry_level = calculate_worry_level(item, operation)
      divisible = (worry_level % monkeys[i][2]).zero?
      target = divisible ? monkeys[i][3][0] : monkeys[i][3][1]
      monkeys[target][0] << worry_level
      # pp "item with worry level #{worry_level} is thrown to monkey #{target}"
      inspections[i] += 1
    end
    monkeys[i][0] = []
  end
end

result = inspections.max(2).reduce(1) { |total, times| total *= times }
puts "Result part 1 is: #{result}"
