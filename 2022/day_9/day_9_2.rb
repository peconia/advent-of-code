# frozen_string_literal: true
input = File.readlines(File.join(__dir__, 'input.txt')).each.map do |load|
  load.split(' ')
end

instructions = input.map { |line| [line[0], line[1].to_i] }

start = [11, 15]
visited = [start]

head = [start[0], start[1]]
others = Array.new(9, [start[0], start[1]])
knots = [head, *others]

def draw(head, visited, knots)
  grid = (0..25).map do |y|
    (0..25).map do |x|
      if head == [x, y]
        'H'
      elsif knots[1] == [x, y]
        '1'
      elsif knots[2] == [x, y]
        '2'
      elsif knots[3] == [x, y]
        '3'
      elsif knots[4] == [x, y]
        '4'
      elsif knots[5] == [x, y]
        '5'
      elsif knots[6] == [x, y]
        '6'
      elsif knots[7] == [x, y]
        '7'
      elsif knots[8] == [x, y]
        '8'
      elsif knots[9] == [x, y]
        'T'
      elsif visited.include?([x, y])
        '#'
      else
        '.'
      end
    end
  end

  grid.each { |line| puts line.join("") }
end


def move(front, back)
  if front[0] == back[0]
    # same column
    if back[1] < front[1] - 1
      back[1] += 1
    elsif back[1] > front[1] + 1
      back[1] -= 1
    end
  elsif front[1] == back[1]
    # same row
    if back[0] < front[0] - 1
      back[0] += 1
    elsif back[0] > front[0] + 1
      back[0] -= 1
    end
  else
    unless (back[0] == front[0] + 1 || back[0] == front[0] - 1) && (back[1] == front[1] + 1 || back[1] == front[1] - 1)
      back[0] = back[0] > front[0] ? back[0] - 1 : back[0] + 1
      back[1] = back[1] > front[1] ? back[1] - 1 : back[1] + 1
    end
  end
  back
end

instructions.each do |instruction|
  direction = instruction[0]
  steps = instruction[1]
  pp "instruction is #{direction} #{steps}"

  steps.times do
    case direction
    when 'U'
      head[1] -= 1
    when 'D'
      head[1] += 1
    when 'R'
      head[0] += 1
    when 'L'
      head[0] -= 1
    end
    9.times do |i|
      knots[i + 1] = move(knots[i].dup, knots[i + 1 ].dup)
    end
    visited.append(knots[9].dup) unless visited.include?(knots[9].dup)

  end
  draw(head, visited, knots)
end

puts "Result part 2 is: #{visited.count}"

