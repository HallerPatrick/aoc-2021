class BingoMap
  attr_accessor :has_won

  def initialize(_map)
    @bingo_map = _map
    @marked_map = Array.new(_map.length)

    (0.._map.length - 1).each do |i|
      @marked_map[i] = Array.new(_map[0].length)
    end
  end

  def is_full_row(row_index)
    @marked_map[row_index].each do |cell|
      return false if cell.nil?
    end
    true
  end

  def get_column(col_index)
    col = []
    @marked_map.each do |row|
      col.append(row[col_index])
    end
    col
  end

  def is_full_columns(col_index)
    @marked_map.each do |row|
      return false if row[col_index].nil?
    end
    true
  end

  def apply_number(_num)
    sum = nil
    @bingo_map.each_with_index do |row, _i|
      row.each_with_index do |cell, _k|
        @marked_map[_i][_k] = 1 if cell == _num
        next unless is_full_row(_i) || is_full_columns(_k)

        _sum = 0
        @bingo_map.each_with_index do |row, r_i|
          row.each_with_index do |cell, r_j|
            _sum += cell.to_i unless @marked_map[r_i][r_j]
          end
        end
        sum = _sum
      end
    end
    sum
  end
end
