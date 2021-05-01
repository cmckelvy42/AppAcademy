def lucas_sequence(n)
    return [] if n == 0
    return [2] if n == 1
    return [2, 1] if n == 2
    ret = lucas_sequence(n - 1)
    return ret << ret[-1] + ret[-2]
end

p lucas_sequence(0)   # => []
p lucas_sequence(1)   # => [2]    
p lucas_sequence(2)   # => [2, 1]
p lucas_sequence(3)   # => [2, 1, 3]
p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]