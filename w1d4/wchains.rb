require 'set'
require 'byebug'

class WordChainer

  def initialize(dict_filename)
    @dictionary = (File.readlines(dict_filename).map(&:chomp)).to_set
  end

  def adjacent_words(word)
    arr = []
    word.split("").each_with_index do |letter, index|
      ('a'..'z').each do |x|
        word[index] = x
        arr += [word.dup] if x != letter
      end
      word[index] = letter
    end
    arr.select { |word| @dictionary.include?(word) }

  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}

    while @current_words.any?
      current_word = @current_words.shift
      adjacent_words(current_word).each do |word|
        unless (@all_seen_words[word] || word == source)
          @all_seen_words[word] = current_word
          @current_words << word
        end
      end
      break if @all_seen_words[target]
    end
    chain_array = []
    current = target
    while current
      chain_array = [current] + chain_array
      current = @all_seen_words[current]
    end
    puts chain_array
  end

end
