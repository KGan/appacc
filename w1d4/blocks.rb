class Array

  def my_each(&prc)
    self.length.times do |index|
      prc.call(self[index])
    end
    self
  end

  def my_map(&prc)
    out_arr = []
    self.my_each do |element|
      out_arr << prc.call(element)
    end
    out_arr
  end

  def my_select(&prc)
    out_arr = []
    self.my_each do |element|
      out_arr << element if prc.call(element)
    end
    out_arr
  end

  def my_inject(&prc)
    var1 = self.first
    self[1...self.length].my_each do |element|
      var1 = prc.call(var1, element)
    end
    var1
  end

  def my_sort!(&prc)
    replace(quicksort(self, prc))
  end

  def my_sort(&prc)
    self.dup.my_sort!
  end

  private
    def quicksort(arr, prc)
      return arr if arr.length < 2
      pivot = arr.pop
      right = []
      left = []
      arr.each do |element|
        if prc.call(element, pivot) == 1
          right << element
        else
          left << element
        end
      end
      return left.my_sort!(&prc) + [pivot] + right.my_sort!(&prc)
    end
end

def eval_block(*args, &prc)
  return "NO BLOCK GIVEN!" if prc == nil
  prc.call(*args)
end
