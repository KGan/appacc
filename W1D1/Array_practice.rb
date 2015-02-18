class Array
  def my_uniq
    uniques = []

    self.each do |element|
      uniques.include?(element) ? next : uniques << element
    end

    uniques
  end

  def two_sum
    zero_pairs = []
    (0...self.length).each do |i|
      j = i + 1
      while j < self.length
        if self[i] + self[j] == 0
          zero_pairs << [i,j]
        end
        j+=1
      end
    end
    zero_pairs
  end
end

def my_transpose(arr)
  size = arr.size
  new_arr = Array.new(size){Array.new}
  arr.each do |row|
    row.size.times do |i|
      new_arr[i] << row[i]
    end
  end
  new_arr
end

def stock_picker(arr)
  buy_sell_day = [0,0]
  curr_max = 0
  arr.size.times do |i|
    j=i+1
    while j < arr.size
      if arr[j] - arr[i] > curr_max
        curr_max = arr[j] - arr[i]
        buy_sell_day = [i,j]
      end
      j+=1
    end
  end
  buy_sell_day
end

def hanoi
  towers = Array.new(3) {Array.new}
  puts "How many disks?"
  input = gets.chomp.to_i
  input.times do |i|
    towers[0] << i + 1
  end
  while true
    hanoi_print(towers)
    puts "Move from what tower? (1, 2 or 3)"
    from_tower = gets.chomp.to_i - 1
    towers[from_tower].first == nil ? next : nil
    puts "What tower to move to? (1, 2 or 3)"
    to_tower = gets.chomp.to_i - 1
    towers[to_tower].first.nil? ? value = input + 1 : value = towers[to_tower].first
    if value < towers[from_tower].first
      # failure
      puts "Can't put larger disk on smaller disk"
      next
    else
      towers[to_tower].unshift(towers[from_tower].shift)
    end
    if towers[0].empty?
      if towers[1].empty? || towers[2].empty?
        puts "you win!"
        return
      end
    end
  end
end

def hanoi_print(towers)
  size_arr = [towers[0].size, towers[1].size, towers[2].size]
  size_arr.max.times do |i|
    line_o = ""
    3.times do |j|
      if towers[j][i]
        line_o += "\t"+towers[j][i].to_s+"\t"
      else
        line_o += "\t-\t"
      end
    end
    puts line_o
  end
  puts "--------------------------------------------------"
  puts "\t1\t\t2\t\t3"
end
