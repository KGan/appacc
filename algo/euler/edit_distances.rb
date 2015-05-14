require 'colorize'
def edit_distance(word1, word2)
  mat = Array.new(word1.length + 1) { Array.new(word2.length + 1) }
  (0..word1.length).each do |i|
    mat[i][0] = i
  end
  (0..word2.length).each do |i|
    mat[0][i] = i
  end

  parent_hash = {}

  (1..word1.length).each do |r|
    (1..word2.length).each do |c|
      if word1[r-1] == word2[c-1]
        mat[r][c] = mat[r-1][c-1]
      elsif word1[r-1] == word2[c-2] && word1[r-2] == word2[c-1]
        mat[r][c] = mat[r-1][c-1]
      else
        mat[r][c] = [mat[r-1][c] + 1, mat[r][c-1] + 1, mat[r-1][c-1] + 1].min
      end
    end
  end

  print '    ' + word2.split('').join(' ') + "\n"
  mat.each_with_index do |row, r|
    print word1[r-1] + ' '
    row.each_with_index do |val, c|
      print val.to_s + " "
    end
    print "\n"
  end

  mat[word1.length][word2.length]


end


def chocolate_distance(target, word1, word2)
  puts target
  mat = Array.new(word1.length + 1) { Array.new(word2.length + 1) }
  # (0..word1.length).each do |i|
  #   mat[i][0] = false
  # end
  # (0..word2.length).each do |i|
  #   mat[0][i] = false
  # end
  #
  # mat[0][0] = true

  target = " " + target

  (0..word1.length).each do |r|
    (0..word2.length).each do |c|
      if r == c && r == 0
        mat[0][0] = true
        next
      end
      if target[r + c] == word1[r - 1] || target[r + c] == word2[c - 1]
        left = mat[r][c-1] && (c-1 > -1)
        top = mat[r-1][c] && (r-1 > -1)
        mat[r][c] = left || top
      else
        mat[r][c] = false
      end
    end
  end

  print '    ' + word2.split('').join(' ') + "\n"
  mat.each_with_index do |row, r|
    if r == 0
      print '  '
    else
      print word1[r-1] + ' '
    end
    row.each_with_index do |val, c|
      print (val ? 'T'.colorize(color: :red) : 'F') + " "
    end
    print "\n"
  end
  mat.last.last
end


def knapsack_distance(stuff, target)

  mat = Array.new(stuff.length + 1) { Array.new(target + 1) }

  mat[0][0] = true

  (1..target).each do |i|
    mat[0][i] = false
  end

  (1..stuff.length).each do |stu|
    (1..target).each do |tar|
      index = tar - stuff[stu - 1]
      mat[stu][tar] = mat.transpose[index][0...stu].inject { |acc, el| acc || el } && index > 0
    end
  end

  print '  ' + ('0'..target.to_s).to_a.map { |n| "%3s" % n }.join('') + "\n"
  mat.each_with_index do |row, r|
    if r == 0
      print '   '
    else
      print "%2s" % stuff[r-1].to_s + ' '
    end
    row.each_with_index do |val, c|
      print " " + (val ? 'T'.colorize(color: :red) : 'F') + " "
    end
    print "\n"
  end
  nil
end

def smallshuffle(arr, number)
  number.times do
    i, j = Integer(rand((arr.length/2)..arr.length)), Integer(rand((arr.length/2)..arr.length))
    arr[i], arr[j] = arr[j], arr[i]
  end
  arr
end

def interleave(word1,word2,scrambled=false)
  word1arr = word1.split('')
  word2arr = word2.split('')
  if scrambled
    word1arr = smallshuffle(word1arr, rand(1..3))
    word2arr = smallshuffle(word2arr, rand(4))
  end
  arr = [word1arr,word2arr]
  interleaved = ''
  until arr[0].empty? && arr[1].empty?
    ind = rand(2)
    word = arr[ind]
    word = arr[(ind+1)%2] if word.empty?
    next if word.empty?
    char = word.shift
    interleaved+=char if char
  end
  interleaved
end

def woven_distance(word1, word2, scrambled=false)
  chocolate_distance(interleave(word1, word2, scrambled), word1, word2)
end
#
# [[0,1],[0,-1]][[:white, :black].index(color)]
#
# case color
# when :white
#   [0,1]
# when :black
#   [0,-1]
# end
