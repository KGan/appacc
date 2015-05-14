
def dot(vec1, vec2)
  return nil if vec1.length != vec2.length
  sum = 0
  vec1.each_index do |ind|
    sum += (vec1[ind] * vec2[ind])
  end
  sum
end

def subtr(vec1, vec2)
  return nil if vec1.length != vec2.length
  [vec1[0] - vec2[0], vec1[1] - vec2[1]]
end

if __FILE__ == $PROGRAM_NAME
  puts 'loading in triangles...'
  triangles = File.readlines('./euler/102triangles.txt').map do |line|
    elem_arr = line.chomp.split(',').map(&:to_i)
    elem_arr.each_slice(2).to_a
  end
  puts "#{triangles.length} triangles loaded!"
  triangles_completed = 0.0
  puts "Computing..."
  total_triangles = triangles.length
  answer = triangles.count do |p1, p2, p3|
    basis1 = subtr(p3, p1)
    basis2 = subtr(p2, p1)
    target = subtr([0,0], p1)

    #project vectors onto each other in preparation
    dot11 = dot(basis1, basis1)
    dot12 = dot(basis1, basis2)
    dot1targ = dot(basis1, target)
    dot22 = dot(basis2, basis2)
    dot2targ = dot(basis2, target)

    #barymetric coordinates
    invert_denom = 1.0 / (dot11 * dot22 - dot12 **2)
    u = (dot22 * dot1targ - dot12 * dot2targ) * invert_denom
    v = (dot11 * dot2targ - dot12 * dot1targ) * invert_denom

    triangles_completed += 1
    percent_complete = triangles_completed/total_triangles*100
    print "\rprocessed...#{percent_complete.round(2)}%"
    sleep(1.0/100.0)
    #now test
    (u >= 0) && (v >= 0) && (u + v < 1)
  end

  puts "\n#{answer} triangles contain the origin"

end
