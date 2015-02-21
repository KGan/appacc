require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      return @board.winner ? (@board.winner != evaluator) : nil
    end
    if evaluator == @next_mover_mark #player to move
      children.each do |child|
        return false unless child.losing_node?(evaluator)
      end
      return true
    else #opponent to move
      children.each do |child|
        return true if child.losing_node?(evaluator)
      end
      return false
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      return @board.winner == evaluator
    end
    if evaluator != @next_mover_mark # opponent to move
      children.each do |child|
        return false unless child.winning_node?(evaluator)
      end
      return true
    else # player to move
      children.each do |child|
        return true if child.winning_node?(evaluator)
      end
      return false
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    empty_squares = []
    (0..2).each do |row|
      (0..2).each do |col|
        # puts @board[[row,col]] ? "\n\n#{row}, #{col} is #{@board[[row,col]]}" : "\n\n#{row}, #{col} is nil"
        empty_squares << [row,col] unless @board[[row,col]]
      end
    end
    empty_squares.map do |move|
      child_board = @board.dup
      child_board.[]=(move, @next_mover_mark)
      next_mark = @next_mover_mark == :o ? :x : :o
      TicTacToeNode.new(child_board, next_mark, move)
    end
  end
end
