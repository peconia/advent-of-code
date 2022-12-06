signal = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"

def find_start_of_packet(signal, length)
  letters = signal.chars.to_a.first(length)
  i = length
  while letters.uniq.length != length
    letters = letters.drop(1)
    letters.push(signal[i])
    i += 1
  end
  i
end

result = find_start_of_packet(signal, 4)

puts "Result part 1 is: #{result}"

result = find_start_of_packet(signal, 14)

puts "Result part 2 is: #{result}"