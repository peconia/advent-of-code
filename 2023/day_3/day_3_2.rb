# frozen_string_literal: true

$engine = File.readlines(File.join(__dir__, 'input.txt')).map(&:strip)

$height = $engine.length
$width = $engine[0].length

def is_in_grid?(x, y)
  x >= 0 && y >= 0 && y < $height && x < $width
end

def engine_part(x, y)
  3.times do |i|
    current_x = x + i -1
    3.times do |j|
      current_y = y + j -1
      next unless is_in_grid?(current_x, current_y)
      next if current_x == x && current_y == y
      if $engine[current_y][current_x] == '*'
        return [current_x, current_y]
      end
    end
  end
  []
end

possible_gears = []
$engine.each_with_index.map do |line, index|
  num = ""
  found = []
  line.strip.chars.each_with_index do |letter, i|
    if /\d/.match(letter)
      num += letter
      gear_index = engine_part(i, index)
      found.append(gear_index) unless gear_index.empty? || found.include?(gear_index)
    else
      unless num.empty? || found.empty?
        possible_gears.append([num.to_i, found])
      end
      num = ""
      found = []
    end
    if i == ($width - 1)
      unless num.empty? || found.empty?
        possible_gears.append([num.to_i, found])
      end
      num = ""
      found = []
    end
  end
end

stars = possible_gears.map { |g| g[1][0] }.to_set.to_a

result = stars.reduce(0) do |total, gear|
  adjacent = possible_gears.filter_map { |g| g[0] if g[1][0] == gear }
  if adjacent.length == 2
    total += adjacent[0] * adjacent[1]
  else
    total
  end
end

pp "result", result