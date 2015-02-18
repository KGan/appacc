def times2(array)
  array.map { |x| x * 2 }
end

class Array
  def my_each(&proc)
    size.times do |i|
      proc.call(self[i])
    end
    self
  end
end

def median(arr)
  arr_n = arr.sort
  if arr_n.count % 2 == 1
    return arr_n[arr_n.count / 2]
  else
    return (arr_n[arr_n.count / 2] + arr_n[(arr_n.count / 2) - 1]) / 2.0
  end
end

def concatenate(arr)
  arr.inject(:+)
end
