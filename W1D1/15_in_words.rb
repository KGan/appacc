class Fixnum
  def in_words
    return 'zero' if self == 0
    num_as_str = ''
    place_words = {
      1_000_000_000_000 => 'trillion ',
      1_000_000_000 => 'billion ',
      1_000_000 => 'million ',
      1_000 => 'thousand '
    }
    remaining = self
    place_words.sort_by { |k, _| k }.reverse.each do |place, word|
      num_as_str += word_for(remaining / place, word)
      remaining %= place
    end
    num_as_str += word_for(remaining)
    num_as_str.strip
  end

  private

    def word_for(num, suffix = '')
      return '' if num == 0
      base_words = {
        1 => 'one ',
        2 => 'two ',
        3 => 'three ',
        4 => 'four ',
        5 => 'five ',
        6 => 'six ',
        7 => 'seven ',
        8 => 'eight ',
        9 => 'nine ',
        10 => 'ten ',
        11 => 'eleven ',
        12 => 'twelve ',
        13 => 'thirteen ',
        14 => 'fourteen ',
        15 => 'fifteen ',
        16 => 'sixteen ',
        17 => 'seventeen ',
        18 => 'eighteen ',
        19 => 'nineteen ',
        20 => 'twenty ',
        30 => 'thirty ',
        40 => 'forty ',
        50 => 'fifty ',
        60 => 'sixty ',
        70 => 'seventy ',
        80 => 'eighty ',
        90 => 'ninety '
      }
      return base_words[num] + suffix if num < 20
      if num < 100
        tens = 0
        (1..10).each do |i|
          if num / (i * 10) == 0
            tens = (i - 1) * 10
            break
          end
        end
        return base_words[tens] + word_for(num % tens) + suffix
      end
      word_for(num / 100, 'hundred ') + word_for(num % 100, suffix)
    end
end
