require 'byebug'

#
# X|O|
# -+-+-
# X|O|
# -+-+-
#  | |X


class Board
  attr_accessor :positions
  @@win_conditions = [
    [0,3,6], #columns
    [1,4,7],
    [2,5,8],
    [0,1,2], #rows
    [3,4,5],
    [6,7,8],
    [0,4,8], #diagonals
    [2,4,6]
  ]

  def initialize
    @positions = Array.new(9, nil)
  end

  def render
    puts
    (0..2).each do |line|
      (0..2).each do |column|
        mark = @positions[line * 3 + column]
        print mark ? mark : " "
        print "|" if column < 2
      end
      print line == 2 ? "\n" : "\n-+-+-\n"
    end
    puts
  end

  def winner
    marks = @positions.uniq
    winner = marks.select do |mark|
      sigils = (0..8).select { |position| @positions[position] == mark }
      @@win_conditions.select do |condition|
        (sigils & condition) == condition
      end.length > 0
    end.inject { |acc, thing| acc or thing }
    # nil wins until someone else wins
  end

  def place_mark(position, mark)
    return false if @positions[position]
    @positions[position] = mark
    true
  end

  def clone
    new_board = Board.new
    new_board.positions = self.positions.dup
    new_board
  end

end

class Game
  def initialize
    @player1 = HumanPlayer.new
    @player2 = ComputerPlayer.new
    @players = [@player1, @player2]
  end

  def play
    @board = Board.new
    turns = 0
    @board.render
    loop do
      @players[turns % 2].get_move(@board)
      @board.render
      winner = @board.winner
      if winner
        puts "#{@players.select { |player| player.mark == winner }[0].name } won!"
        break
      end
      turns += 1
    end
  end
end


class HumanPlayer
  attr_reader :name, :mark

  def initialize
    @name = "You"
    @mark = "X"
  end

  def get_move(board)
    loop do
      print "Make move (type 1-9) : "
      move = gets.chomp.to_i
      next if move < 1 || move > 9
      break if board.place_mark(move - 1, @mark)
    end
  end

end

class ComputerPlayer

  attr_reader :name, :mark

  def initialize
    @name = "The Computer"
    @mark = "O"
  end

  def get_move(board)
    possible_moves = []
    (0..8).each do |position|
      board_check = board.clone
      if board_check.place_mark(position, @mark)
        possible_moves.push(position)
      end
      if board_check.winner
        board.place_mark(position, @mark)
        break
      end
    end
    board.place_mark(possible_moves.sample, @mark)
  end

end
