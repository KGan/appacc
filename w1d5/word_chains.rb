require 'set'
require 'byebug'
class WordChainer


  def initialize (dictionary_file_name)
    @dictionary =  File.readlines(dictionary_file_name).map(&:chomp).to_set
  end

  def adjacent_words(word)
    possible_words = []
    word.split(//).each_with_index do |letter, index|
      ('a'..'z').each do |alphabet|
        if alphabet != letter
          new_word = word.dup
          new_word[index] = alphabet
          possible_words << new_word if @dictionary.include?(new_word)
        end
      end
    end

    possible_words
  end

  def run (source, target)
    @current_words = [source]
    all_words = []
    @all_seen_words = { source => nil }
    while current_node = @current_words.shift
      all_words += [current_node]
      children_node = adjacent_words(current_node)
      if current_node == target
        break
      end
      children_node.each do |child|
        if child != source && !@all_seen_words[child]
            @all_seen_words[child] = current_node
            @current_words << child
        end
      end
    end
    build_path(target)
  end

  def build_path(target)
    current_word = target
    path = []
    while current_word != nil
      path << current_word
      current_word = @all_seen_words[current_word]
    end
    puts path.reverse
  end
  # @dictionary.each do |dic_word|
  #
  #   common_letters = word.split(//) & dic_word.split(//)
  #   diff_letter_count = dic_word.length - common_letters.length
  #
  # end



end
