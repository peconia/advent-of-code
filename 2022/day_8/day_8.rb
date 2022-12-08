# frozen_string_literal: true

trees = []
File.open(File.join(__dir__, 'input.txt')).each do |line|
  trees.push(line.strip.chars.map { |c| c })
end

height = trees.length
width = trees[0].length

t = trees.each_with_index.map do |row, y|
  row.each_with_index.map do |tree, x|
    (y.zero? || y == height - 1 || x.zero? || x == width - 1) ||
      (0..y - 1).none? { |i| trees[i][x] >= tree } ||
      (y + 1..height - 1).none? { |i| trees[i][x] >= tree } ||
      (0..x - 1).none? { |i| trees[y][i] >= tree } ||
      (x + 1..width - 1).none? { |i| trees[y][i] >= tree }
  end
end

result = t.flatten.select { |i| i }

puts "Result part 1 is: #{result.count}"

part_2 = trees.each_with_index.map do |row, y|
  row.each_with_index.map do |tree, x|
    if y.zero? || y == height - 1 || x.zero? || x == width - 1
      0
    else
      top = 0
      (0..y - 1).to_a.reverse.each do |i|
        top += 1
        break if trees[i][x] >= tree
      end

      bottom = 0
      (y + 1..height - 1).each do |i|
        bottom += 1
        break if trees[i][x] >= tree
      end

      left = 0
      (0..x - 1).to_a.reverse.each do |i|
        left += 1
        break if trees[y][i] >= tree
      end

      right = 0
      (x + 1..width - 1).each do |i|
        right += 1
        break if trees[y][i] >= tree
      end

      bottom * top * left * right
    end

  end
end

result_2 = part_2.flatten.max

puts "Result part 2 is: #{result_2}"

