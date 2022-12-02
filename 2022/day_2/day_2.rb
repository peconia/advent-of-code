input = File.read(File.join(__dir__, 'input.txt'))

input = input.split("\n").map do |load|
  load.split("\s")
end

def letter_to_value(letter)
  case letter
  when "A", "X"
    return 1
  when "B", "Y"
    return 2
  when "C", "Z"
    return 3
  else
    return 0
  end
end

def count_points_for_me(other_player, me)
  if other_player == me
    points = 3
  elsif me == 1
    points = other_player == 3 ? 6 : 0
  elsif other_player == 1
    points = me == 3 ? 0 : 6
  else
    points = me > other_player ? 6 : 0
  end

  me + points
end

def get_wanted_value(other_player, result)
  #1 = lose, 2 = draw, 3 = win
  case result
  when 1
    return other_player == 1 ? 3 : other_player - 1
  when 2
    return other_player
  when 3
    return other_player == 3 ? 1 : other_player + 1
  end
end

result_1 = input.map do |game|
  count_points_for_me(letter_to_value(game[0]), letter_to_value(game[1]))
end

result_2 = input.map do |game|
  count_points_for_me(letter_to_value(game[0]), get_wanted_value(letter_to_value(game[0]), letter_to_value(game[1])))
end

result_1 = result_1.sum
result_2 = result_2.sum

puts "Result part 1 is: #{result_1}"

puts "Result part 2 is: #{result_2}"
