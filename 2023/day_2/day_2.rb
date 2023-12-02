# frozen_string_literal: true

# part 1

result = File.readlines(File.join(__dir__, 'input.txt')).reduce(0) do |total, line|
  parts = line.split(': ')
  game_number = parts[0].delete("^0-9").to_i
  draws = parts[1].split('; ')

  a = draws.map do |draw|
    colors = draw.split(', ')
    res = colors.map do |c|
      color = c.count("^1234567890")
      qty = c.delete("^0-9").to_i
      case color
      when 4
        qty <= 12
      when 5
        qty <= 14
      else
        qty <= 13
      end
    end
    !res.any?(false)
  end

  total += game_number if a.all?(true)
  total
end

pp result

# part 2

result = File.readlines(File.join(__dir__, 'input.txt')).reduce(0) do |total, line|
  parts = line.split(': ')
  draws = parts[1].split('; ')

  needed = [0, 0, 0]
  draws.each do |draw|
    colors = draw.split(', ')
    colors.each do |c|
      color = c.strip.count("^1234567890")
      qty = c.delete("^0-9").to_i
      case color
      when 4
        needed[0] = qty if needed[0] < qty
      when 5
        needed[2] = qty if needed[2] < qty
      else
        needed[1] = qty if needed[1] < qty
      end
    end
  end

  total + (needed[0] * needed[1] * needed[2])
end

pp result