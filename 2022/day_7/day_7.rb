# frozen_string_literal: true

lines = File.readlines(File.join(__dir__, 'input.txt')).map { |line| line.strip.split(' ') }

class Hash
  def deep_merge(h)
    self.merge(h) do |k, old, new|
      if old.instance_of?(Hash) && new.instance_of?(Hash)
        old.deep_merge(new)
      else
        new
      end
    end
  end
end

file_system = Hash.new
current_dir = []
dirs = []

lines.each do |line|
  if line.count == 3 # this is cd
    line[2] == '..' ? current_dir.pop : current_dir.push(line[2])
  elsif line[0] == 'dir'
    dir = current_dir.clone.push(line[1])
    dirs.push(dir) unless dirs.include?(dir)
  elsif line[0] != '$'
    keys = current_dir.clone + [line[1]]
    file_system = file_system.deep_merge(keys.reverse.inject(line[0].to_i) { |assigned_value, key| { key => assigned_value } })

  end
end

def dir_total_size(dir_hash)
  dir_hash.values.reduce(0) do |total, value|
    case value
    when Hash then total + dir_total_size(value)
    else
      total + value.to_i
    end
  end
end

dirs = dirs.map { |dir| [dir, dir_total_size(file_system.dig(*dir))] }

small_dirs_total = dirs.reduce(0) do |total, dir|
  total += dir[1] if dir[1] <= 100_000
  total
end

puts "Result part 1 is: #{small_dirs_total}"

top_level_files = file_system['/'].reduce(0) do |total, item|
  total += item[1] if item[1].is_a? Integer
  total
end

top_level_dir_totals = dirs.reduce(0) do |total, dir|
  total += dir[1] if dir[0].length == 2
  total
end

total_used = top_level_dir_totals + top_level_files
space_needed = 30_000_000 - (70_000_000 - total_used)

candidates = dirs.filter_map { |dir| dir[1] if dir[1] >= space_needed }

puts "Result part 2 is: #{candidates.min}"
