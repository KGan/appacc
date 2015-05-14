class Minesweeper

  def initialize(**options)
    defaults = {}
    @options = {}.merge(options)
  end

  def setup(board_size)
    @board = Board.new(board_size)
  end

  def run

  end

  def play

  end

  def display
    @board.display
  end

end

class Board

  def initialize(size)
    @size = size
  end

  def display

  end

end

class Tile

  def initialize(**options)
    @neighbors = options[:neighbors]
    @mark = options[:mark]
    compute_neighbors
  end

  def isBomb?
    @mark == 'B'
  end

  def display
    render_mark
  end

  private
    def compute_neighbors
      @nbc = @neighbors.count{ |neighbor| neighbor.isBomb? }
    end

    def render_mark

    end

end