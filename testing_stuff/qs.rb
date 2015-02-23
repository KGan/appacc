class Array
  def quicksort(&prc)
    prc ||= Proc.new {|a,b| a<=>b}

    return self if length < 2

    left = []
    right = []
    pivot = pop
    each do |ele|
      if prc.call(ele, pivot) == -1
        left << ele
      else
        right << ele
      end
    end

    return left.quicksort(&prc) + [pivot] + right.quicksort(&prc)
  end

  def bfs(sorted_array)
    while 
  end

  def children(lower, upper)
    mid = (lower + upper)/2
    [lower + mid/2, upper - mid/2]
  end
end
