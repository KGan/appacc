class RPSGame
  def initialize
    @moves = ['rock', 'paper', 'scissors']
  end

  def rps
      move = getPlayerMove
      computer_move = getComputerMove
      winner = play(move, computer_move)
      print_winner(winner, computer_move)
  end

  def print_winner(winner, computer_move)
    outcome = ["Win", "Lose", "Draw"]
    winner = winner ? winner : 2
    "#{@moves[computer_move].capitalize}, #{outcome[winner]}"
  end

  def getPlayerMove
    move = ""
    while !@moves.include?(move)
      move = gets.chomp.downcase
    end
    @moves.index(move)
  end

  def getComputerMove
    rand(3)
  end

  def play(move0, move1)
    [nil, 0, 1][(move0 - move1) % 3]
    #-1, 2 right player
    #1, -2 left
    #0 tie
  end
end


def remix (drinks)
  map = (0...drinks.length).to_a.shuffle
  properlyshuffled = false
  while !properlyshuffled
    properlyshuffled = true
    map.each_with_index do |num, index|
      if num == index
        map[num], map[(num + 1) % map.length] = map[(num + 1) % map.length], map[num]
        properlyshuffled = false
      end
    end
  end
  drinks.each_with_index.map do |drink, index|
    [drink[0], drinks[map[index]][1] ]
  end
end
