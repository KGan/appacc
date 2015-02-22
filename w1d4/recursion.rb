def exp(b, n)
  return 1 if n == 0
  if n % 2 == 1
    return b * exp(b,n/2) * exp(b,n/2)
  else
    return exp(b,n/2) * exp(b,n/2)
  end
end

class Array
  def deep_dup
    new_arr = []
    self.each do |element|
      if element.is_a? Array
        new_arr << element.deep_dup
      else
        new_arr << element
      end
    end
    new_arr
  end

  def subsets
    arr = []
    return [self, []] if size < 2
    each do |el|
      arr += (self - [el]).subsets
    end
    arr += [self]
    arr.uniq.sort_by(&:length)
  end
end

def fib(n)
  puts "Iterative fibonacci: #{fib_iter(n)}"
  puts "Recursive fibonacci: #{fib_recur(n)}"
end

def fib_iter(n)
  arr = [1,1]
  return [arr[n-1]] if n < 3
  (n-2).times do
    arr << arr[-2] + arr[-1]
  end
  arr
end

def fib_recur(n)
  return [0] if n == 0
  return [1] if n == 1
  return fib_recur(n-1) + [fib_recur(n-1)[-1] + fib_recur(n-2)[-1]]
end

def bs(arr, target)
  return nil if arr.size < 2 && arr[0] != target
  if arr[arr.length/2] == target
    return target
  elsif arr[arr.length/2] > target
    bs(arr[(arr.length/2 + 1)...arr.length], target)
  elsif arr[arr.length/2] < target
    bs(arr[0...(arr.length/2)], target)
  end
end

def make_change(money, coins)
  vals = []
  coins.each_with_index do |coin, index|
    return [coin] if money == coin
    vals << [coin] + make_change(money-coin, coins.drop(index)) if money-coin > 0
  end
  vals.min_by { |combination| combination.size }
end

def merge_sort(arr)
  return arr if arr.length < 2
  left = merge_sort(arr[0...arr.length/2])
  right = merge_sort(arr[arr.length/2..-1])
  merge(left, right)
end

def merge(left,right)
  arr = []
  until left.empty? || right.empty?
    left.first < right.first ? arr << left.shift : arr << right.shift
  end
  arr += left + right
end
