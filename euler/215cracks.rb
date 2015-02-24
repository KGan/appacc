require 'set'

Node = Struct.new(:row, :level) do
  def legal_neighbors
    self.row.legal_neighbors
  end
end

class Row
  attr_accessor :blocks, :cracks, :legal_neighbors

  def initialize(blocks)
    @blocks = blocks
    @cracks = Set.new
    sum = 0
    @blocks[0..-2].each do |block|
      sum += block
      @cracks.add(sum)
    end
  end

  def legal?(other_row)
    (@cracks & other_row.cracks).empty?
  end

  def create_legal_neighbors(all_rows)
    selection = Proc.new { |row_index| self.legal?(all_rows[row_index]) }
    @legal_neighbors = (0...all_rows.length).select(&selection)
  end
end


class Wall
  attr_reader :all_rows
  BLOCK_SIZES = [2, 3]

  def initialize(width, height)
    @width = width
    @height = height - 1
  end

  def solve
    # possible_rows
    generate_all_rows
    create_all_legal_neighbors(@all_rows)
    puts run_dynamic_programming(@all_rows)
  end

  def create_all_legal_neighbors(all_rows)
    all_rows.each do |row|
      row.create_legal_neighbors(all_rows)
    end
  end

  def generate_all_rows
    @all_rows = create_all_rows(@width).map { |poss_row| Row.new(poss_row) }
  end

  def run_dynamic_programming(all_rows)
    walls = [1] * all_rows.length
    (@height).times do
      walls_new = walls.dup
      walls.each_index do |wall_index|
        walls_new[wall_index] = all_rows[wall_index].legal_neighbors.inject(0) do |sum, neighbor|
          # puts sum ? "#{sum} #{wall_index} #{neighbor}" : "$$\n"
          sum + walls[neighbor]
        end
      end
      walls = walls_new
      # print "Walls : #{walls}\n"
    end
    walls.inject(:+)
  end

  def create_all_rows(width)
    return [[]] if width == 0
    return nil if width < BLOCK_SIZES.min
    possible_rows = []
    BLOCK_SIZES.each do |block_size|
      subrows = self.create_all_rows(width - block_size)
      next if subrows.nil?
      subrows.each do |subrow|
        possible_rows << ([block_size] + subrow)
      end
    end
    possible_rows
  end
end

if __FILE__ == $PROGRAM_NAME
  wall = Wall.new(32, 10)
  wall.solve
end
