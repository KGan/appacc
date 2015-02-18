def num_to_s(num, base)
  output_string = ""
  digits = {
    0 => '0', 1 => '1', 2 => '2',
    3 => '3', 4 => '4', 5 => '5',
    6 => '6', 7 => '7', 8 => '8',
    9 => '9', 10=> 'A', 11=> 'B',
    12=> 'C', 13=> 'D', 14=> 'E',
    15=> 'F'
  }
  power = 0
  while base**power <= num
    output_string = digits[(num/(base**power)) % base] + output_string
    power+=1
  end
  output_string
end

def caesar(string, num)
  converted = ""
  string.each_char do |char|
    ascii = char.ord
    if ascii < 97 || ascii > 122
      converted << char
      next
    end
    mod_num = num % 26
    ascii += mod_num
    ascii > 122 ? ascii -= 26 : nil
    ascii < 97 ? ascii += 26 : nil
    converted << ascii.chr
  end
  converted
end
