# frozen_string_literal: true

input = File.readlines(File.join(__dir__, 'input.txt')).each.map { |load| load.split(' ') }.map do |line|
  line.length > 1 ? [0, line[1].to_i] : 0
end

instructions = input.flatten
x = 1

instructions.each_with_index do |instruction, index|
  if (index % 40).zero?
    print("\n")
  end
  pixel = (index % 40).between?(x - 1, x + 1) ? '#' : '.'
  print(pixel)
  x += instruction
end
