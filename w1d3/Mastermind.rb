class Mastermind
  def initialize
    @turncounter = 0
  end

  def play
    @code = Code.new
    @code.generate_code
    turncounter = 0
    loop do
      guess = get_move
      exact, near = @code.evaluate(guess)
      turncounter += 1
      puts "Turn #{turncounter}: #{exact} exact matches and #{near} near matches"
      if exact > 3
        puts "You Win!"
        break
      end
      if turncounter > 9
        puts "Max turns used, you lose!"
        break
      end
    end
  end

  def get_move
    print 'What is your guess?'
    guess = gets.chomp.split('')
  end

end

class Code
  attr_reader :options
  def initialize(options = {})
    @options = {:colors => ['r', 'g', 'b', 'y', 'o', 'p'], :turns => 10, :codelength => 4}
    @code = []
    @options.merge(options)
  end

  def evaluate(guess)
    total_matches = (guess & @code).count
    em = exact_matches(guess)
    return em, total_matches - em
  end

  def exact_matches(guess)
    counter = 0
    guess.each_with_index do |element, i|
      counter += 1 if @code[i] == element
    end
    counter
  end

  def generate_code
    @code = @options[:colors].shuffle.sample(options[:codelength])
  end
end
