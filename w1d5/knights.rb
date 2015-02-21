class KnightPathFinder
  def self.valid_moves(pos)
    [].tap do |arr|
      knight_jumps = [
        [2,1], [2,-1], [-2, 1], [-2, -1],
        [1,2], [1,-2], [-1,2], [-1,-2]
      ]

      knight_jumps.each do |move|
        potential = [pos[0]+move[0], pos[1]+move[1]]
        arr << potential if legal?(potential)
      end
    end
  end

  def initialize (starting_pos)
    @starting_pos = starting_pos
    @visited_positions = {starting_pos => nil}
    build_move_tree
  end

  def self.legal?(position)
    return position[0].between?(0,7) && position[1].between?(0,7)
  end

  def find_path(target_pos)
    walk = target_pos
    path = []
    until walk == nil
      path.unshift(walk)
      walk = @visited_positions[walk]
    end
    return path
  end

  def build_move_tree
    queue = [@starting_pos]
    while current_position = queue.shift
      new_move_positions(current_position).each do |new_pos|
        @visited_positions[new_pos] = current_position
        queue << new_pos
      end
    end
  end

  def new_move_positions(pos)
    self.class.valid_moves(pos).select do |position|
      !@visited_positions[position] && position != @starting_pos
    end
  end


end
