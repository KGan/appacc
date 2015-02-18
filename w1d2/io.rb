# Write a number guessing game. The computer should choose a number between 1 and 100. It should prompt the user for guesses. Each time, it will prompt the user for a guess; it will return too high or too low. It should track the number of guesses the player took.
# Write a program that prompts the user for a file name, reads that file, shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You could create a random number using the Random class, or you could use the shuffle method in array.
# You've written an RPN calculator. Practice by rewriting your version better than you had before. It should have a user interface which reads from standard input one operand or operator at a time. You should be able to invoke it as a script from the command line. You should be able to, optionally, give it a filename on the command line, in which case it opens and reads that file instead of reading user input.
# See the if __FILE__ == $PROGRAM_NAME trick described in the debugger chapter.
# 5 1 2 + 4 * + 3 - should return 14

def guessing_game
  true_number = rand(100)
  guesses = 0
  loop do
    print "guess a number :"
    n = gets.chomp.to_i
    case
    when n < true_number
      puts 'too low'
      guesses += 1
    when n > true_number
      puts 'too high'
      guesses += 1
    when n == true_number
      puts "got it in #{guesses} guesses!"
      break
    end
  end
end

def file_shuffle
  filename = ""
  loop do
    print 'give me a file name :'
    filename = gets.chomp
    File.exists?(filename) ? break : "file doesn't exist!"
  end
  line_array = File.readlines(filename)
  line_array.shuffle!
  File.open("#{filename}-shuffled.txt", "w") do |f|
    f.puts(line_array)
  end
end

class RPNCalculator

  attr_accessor :value

  def initialize
    @cstack = []
    @value = nil
  end

  def push(num)
    @cstack.push(@value) if @value
    @value = num.to_f
  end

  @@operations = {:plus => :+, :minus => :-, :times => :*, :divide => :/}

  @@operations.each do |operation, symbol|
    define_method operation do
      raise "calculator is empty" if @cstack.empty?
      @value = @cstack.pop.send(symbol, @value)
    end
  end

  def tokens(str)
    str.split(" ").map {|tokest|
      if /[0-9]+/.match(tokest) then
        tokest.to_f
      else
        tokest.to_sym
      end
    }
  end

  def evaluate(str)
    self.tokens(str).each do |token|
      if token.is_a? Numeric then
        self.push(token)
      else
        self.send(@@operations.invert[token])
      end
    end
    self.value
  end

  def get_char
    begin
      system("stty raw -echo")
      str = STDIN.getc
    ensure
      system("stty -raw echo")
    end
    print str.chr
    str.chr
  end

  def realtime
    loop do
      fullstring = ""
      loop do
        c = get_char
        fullstring << c
        break if c =~ /[^0-9]/
      end
      fullstring.chomp!
      break if fullstring == "q"
      if fullstring[-1] =~ /[^0-9]/
        puts
        fullstring = fullstring[0..-2] << " " << fullstring[-1]
      end
      puts evaluate(fullstring)
    end
  end
end
