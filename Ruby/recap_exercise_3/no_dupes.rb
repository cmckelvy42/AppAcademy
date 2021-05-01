def no_dupes?(arr)
    counts = Hash.new 0
    arr.each {|e| counts[e] += 1}
    return counts.keys.select{|k| counts[k] == 1}
end

p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
p no_dupes?([true, true, true])   