require 'colorize'

def integer_partition(set)
  set
  set_sum = set.inject(:+)
  mat = DpArray.new(set.length + 1) { DpArray.new(set_sum / 2 + 1) }
  mat[0].map! { 0 }
  mat.each do |row|
    row[0] = 0
  end
  mat[0][0] = 1
  p mat[0]
  mat[1..-1].each_with_index do |row, ri|
    row.each_with_index do |sum, si|
      prev_sum = mat[0..ri].inject(0) { |acc, row| si - set[ri] < 0 ? 0 : acc + row[si - set[ri]] }
      row[si] = prev_sum
    end
  end

  print '  ' + ('0'..(set_sum / 2).to_s).to_a.map { |n| "%3s" % n }.join('') + "\n"
  mat.each_with_index do |row, r|
    if r == 0
      print '   '
    else
      print "%2s" % set[r-1].to_s + ' '
    end
    row.each_with_index do |val, c|
      print " " + (val == 0 ? '0' : val.to_s.colorize(color: :red)) + " "
    end
    print "\n"
  end
  nil
end



class DpArray < Array
  # def [](i)
  #   i < 0 ? 0 : super(i)
  # end
end


integer_partition([7,8,5,4,6,3,2,1])
