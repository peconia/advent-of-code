# frozen_string_literal: true

$engine = File.readlines(File.join(__dir__, 'input.txt')).map(&:strip)

$height = $engine.length
$width = $engine[0].length

def is_in_grid?(x, y)
  x >= 0 && y >= 0 && y < $height && x < $width
end

def has_sym(x, y)
  3.times do |i|
    current_x = x + i -1
    3.times do |j|
      current_y = y + j -1
      next unless is_in_grid?(current_x, current_y)
      next if current_x == x && current_y == y
      return true if /[^\d.]/.match($engine[current_y][current_x])
    end
  end
  false
end

total = 0
$engine.each_with_index.map do |line, index|
  num = ""
  found = false
  line.strip.chars.each_with_index do |letter, i|
    if /\d/.match(letter)
      num += letter
      found = has_sym(i, index) unless found
    else
      if !num.empty? && found
        total += num.to_i
      end
      num = ""
      found = false
    end
    # check if end
    if i == ($width - 1)
      if !num.empty? && found
        total += num.to_i
      end
      num = ""
      found = false
    end
  end
end

pp total