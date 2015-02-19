class Hangman
  attr_reader :options
  def initialize(options = {})
    @options={ :max_guesses => 18 }.merge(options)
  end

  def play(guessing_player = HumanPlayer.new, checking_player = ComputerPlayer.new)
    # asign players
    # checking_player gets word
    # tells word.length
    length = checking_player.pick_word
    # loop
    turn_counter = 0
    guessing_player.init_guess(length)
    loop do
      #guessing_player makes guess
      guess = guessing_player.guess
      # try(guess)
      # output feedback
      word_so_far = checking_player.try(guess)
      guessing_player.record(word_so_far)
      if !word_so_far.include?('_')
        puts "win"
        break
      end
      if turn_counter > options[:max_guesses]
        puts 'loss'
        break
      end
      turn_counter += 1
      puts "#{turn_counter}"
    end
  end
end

class HumanPlayer
  def guess
    puts "Make a guess"
    gets.chomp
  end

  def pick_word
    puts "How long is your word?"
    gets.chomp.to_i
  end

  def try(guess)
    puts "Computer's guess: #{guess}"
    puts "What is the word so far?"
    gets.chomp
  end

  def record(str)
    puts "Word so far: #{str}"
  end

  def init_guess(length)
    puts "word is #{length} letters long"
  end
end

class ComputerPlayer
  def initialize
    load_dictionary('dictionary.txt')
  end

  def init_guess(length)
    @tried_letters = []
    @guessing_dictionary = @dictionary.select do |word|
      word.length == length
    end
    cal_freq
  end

  def guess
    most_frequent_letter = @letter_frequency.max_by { |_,value| value }
    @letter_frequency[most_frequent_letter[0]] = 0
    @tried_letters << most_frequent_letter[0]
    puts "Guessed_letter: #{most_frequent_letter[0]}"
    most_frequent_letter[0]
  end

  def pick_word
    @secret = secretize(@dictionary.sample)
    # puts @secret
    return word_length
  end

  def try(guess)
    check(guess)
    respond
  end

  def record(word_so_far)
    puts "Word so far: #{word_so_far}"
    @guessing_dictionary = @guessing_dictionary.select  do |word|
      !word.split("").each_with_index.map do |letter, i|
        word_so_far[i] == letter ||
        word_so_far[i] == "_"
      end.include?(false)
    end
    cal_freq
  end

  private
    def load_dictionary(filename)
      @dictionary ||= File.readlines(filename).map(&:chomp)
    end

    def check(guess)
      @secret.each do |letter|
        letter[1] = true if letter[0] == guess
      end
    end

    def word_length
      @secret.length
    end

    def respond
      @secret.map do |letter|
        letter[1] ? letter[0] : '_'
      end.join('')
    end

    def secretize(str)
      str.split("").map do |letter|
        [letter, false]
      end
    end

    def cal_freq
      @letter_frequency = Hash.new(0)
      @guessing_dictionary.each do |word|
        word.split('').each do |letter|
          @letter_frequency[letter] += 1 unless @tried_letters.include?(letter)
        end
      end
    end
end

if __FILE__ == $PROGRAM_NAME #are we running this as a script
  puts "Guessing player is alive(human)?"
  if gets.chomp == "yes"
    p1 = HumanPlayer.new
  else
    p1 = ComputerPlayer.new
  end

  puts "Checking player is alive(human)?"
  if gets.chomp == "yes"
    p2 = HumanPlayer.new
  else
    p2 = ComputerPlayer.new
  end
  game = Hangman.new
  game.play(p1, p2)
end
