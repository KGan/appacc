# puts 'Bools? eg(TFTTFTFFTFT)'
# bool_array = []
# bool_strings = []
# op_arr = []
# gets.chomp.strip.split('').each do |char|
#   bool_array << (char == 'T')
#   bool_strings << char
# end
# puts 'operators? eg(^vx)'
# op_arr = gets.chomp.strip.split('')
# raise "need at least n-1 operators" if op_arr.length < bool_array

def bool_dps(bool_array, opp_arr)
  mat = Array.new(bool_array.length) { Array.new(bool_array.length, 0) }

  # initialize our array
  (0...bool_array.length).each do |i|
    mat[i][i] = 1 if bool_array[i]
  end

  (1...mat.length).each do |j|  # j - 1 is to the left, i + 1 is down, doing mat[i][j]
    (j - 1).downto(0).each do |i|
      size = [2 ** (j - i - 2), 1].max
      left_sum = mat_sum(bool_array[j], opp_arr[j - 1], mat[i][j-1], size)
      right_sum = mat_sum(bool_array[i], opp_arr[i], mat[i + 1][j], size)
      mat[i][j] = left_sum + right_sum
    end
  end

  # bool_array_strings = bool_array.map { |bool| bool ? 'T' : 'F' }


  # print '    ' + bool_array.join(' ') + "\n"
  mat.each_with_index do |row, r|
    # print word1[r-1] + ' '
    row.each_with_index do |val, c|
      print val.to_s + " "
    end
    print "\n"
  end

end

def mat_sum(bool, opp, prev_mat, size)
  case opp
  when '^'
    bool ? prev_mat : 0
  when 'v'
    bool ? size : prev_mat
  when 'x'
    bool ? size - prev_mat : prev_mat
  end
end


bool_dps([false, false, true, false, true], %w(x ^ v v))























# sum_at_right = case opp_arr[j - 1]
# when '^'
#   bool_array[j] ? mat[i][j-1] : 0
# when 'v'
#   bool_array[j] ? 2 ** (i - j - 1) : mat[i][j-1]
# when 'x'
#   bool_array[j] ? 2 ** (i - j - 1) - mat[i][j-1] : mat[i][j-1]
# end
# sum_at_left = case opp_arr[i]
# when '^'
#   bool_array[i] ? mat[i+1][j] : 0
# when 'v'
#   bool_array[i] ? 2 ** (i - j - 1) : mat[i+1][j]
# when 'x'
#   bool_array[i] ? 2 ** (i - j - 1) - mat[i+1][j] : mat[i+1][j]
# end
