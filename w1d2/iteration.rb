def dict
  @dict ||= begin
    a = {}
    File.open('dictionary.txt').each do |word|
      a[word.chomp] = true
    end
    a
  end
  @dict
end

def factor(n)
  (1..Math.sqrt(n).round).each do |factor|
    puts "#{factor}, #{n/factor}" if n % factor == 0
  end
end

def bubble_sort(arr)
  changed = false
  while !changed
    changed = false
    (0...arr.length).each do |index|
      if arr[index + 1] < element
        arr[index], arr[index + 1] = arr[index + 1], arr[index]
        changed = true
      end
    end
  end
end

def substrings(string)
  results = []
  (0...string.length).each do |index1|
    (index1..string.length).each do |index2|
      results << string[index1..index2]
    end
  end
  results.uniq
end

def subwords(string, dict = dict)
  substrings(string).each do |substring|
    puts substring if dict[substring]
  end
  nil
end
