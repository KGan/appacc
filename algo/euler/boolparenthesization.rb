# puts 'Bools? eg(TFTTFTFFTFT)'
#

def bool_dps(bool_array, opp_arr)
  mat = Array.new(bool_array.length) { Array.new(bool_array.length, 0) }

  # initialize our array
  (0...bool_array.length).each do |i|
    mat[i][i] = 1 if bool_array[i]
    next if (i + 1) == bool_array.length
    bc = bool_array[i]
    bn = bool_array[i+1]

    case opp_arr[i]
    when '^'
      mat[i][i+1] = 1 if bc && bn
    when 'x'
      mat[i][i+1] = 1 if bc ^ bn
    when 'v'
      mat[i][i+1] = 1 if bc || bn
    end
  end

  (2...mat.length).each do |j|  # j - 1 is to the left, i + 1 is down, doing mat[i][j]
    (j - 2).downto(0).each do |i|
      size = [2 ** (j - i - 2), 1].max
      left_sum = mat_sum(bool_array[j], opp_arr[j - 1], mat[i][j-1], size)
      right_sum = mat_sum(bool_array[i], opp_arr[i], mat[i + 1][j], size)
      mat[i][j] = left_sum + right_sum
    end
  end

  bool_array_strings = bool_array.map { |bool| bool ? 'T' : 'F' }
  print_arr = bool_array_strings.zip(opp_arr).flatten.compact

  # print '    ' + bool_array.join(' ') + "\n"
  print '    ' + print_arr.join('  ') + "\n"
  mat.each_with_index do |row, r|
    # print word1[r-1] + ' '
    row.each_with_index do |val, c|
      print "%5s" % val + " "
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

ops = %w(x ^ v)
loop do
  system('clear')
  bool_array, ops_array = [], []
  18.times do
    bool_array << rand(100).odd?
    ops_array << ops[rand(1000) % 3]
  end
  bool_array << rand(2).odd?

  bool_dps(bool_array, ops_array)
  gets
end

# bool_dps([false, false, true, false, true], %w(x ^ v v))
