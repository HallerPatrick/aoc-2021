require_relative 'bingo_map'

file = File.open('input.txt')

lines = file.readlines.map(&:chomp)

file.close

input_numbers = lines.first.split(',')

bingo_maps_lines = lines[2..-1]

bingo_maps = []

current_bingo_map = []

bingo_maps_lines.each do |line|
  if line.length == 0
    bingo_maps.append(BingoMap.new(current_bingo_map))
    current_bingo_map = []
  else
    current_bingo_map.append(line.split(' '))
  end
end

last_result = 0
input_numbers.each do |_number|
  bingo_maps.each_with_index do |bingo_map, _i|
    result = bingo_map.apply_number(_number)
    next unless result

    next if bingo_map.has_won

    res = result * _number.to_i
    last_result = res
    bingo_map.has_won = true
  end
end

puts last_result
