input = File.readlines(File.join(__dir__, 'input.txt')).each.map do |load|
  load.split(' ')
end

instructions = input.map { |line| [line[0], line[1].to_i] }

start = [0, 0]
visited = [start]

tail = [start[0], start[1]]
head = [start[0], start[1]]

instructions.each do |instruction|
  direction = instruction[0]
  steps = instruction[1]

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

    # check how tail moves
    if head[0] == tail[0]
      # same column
      if tail[1] < head[1] - 1
        tail[1] += 1
      elsif tail[1] > head[1] + 1
        tail[1] -= 1
      end
    elsif head[1] == tail[1]
      # same row
      if tail[0] < head[0] - 1
        tail[0] += 1
      elsif tail[0] > head[0] + 1
        tail[0] -= 1
        end
    else
      unless (tail[0] == head[0] + 1 || tail[0] == head[0] - 1) && (tail[1] == head[1] + 1 || tail[1] == head[1] - 1)
        tail[0] = tail[0] > head[0] ? tail[0] - 1 : tail[0] + 1
        tail[1] = tail[1] > head[1] ? tail[1] - 1 : tail[1] + 1
      end
    end
    visited.append(tail.dup) unless visited.include?(tail.dup)
  end
end

puts "Result part 1 is: #{visited.count}"
