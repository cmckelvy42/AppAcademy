def multiply(n1, n2)
    if n2 < 0
        n1 *= -1 
        n2 *= -1
    end
    return n1 if n2 == 1
    return 0 if n2 == 0
    return n1 + multiply(n1,n2 - 1)
end

p multiply(3, 5)        # => 15
p multiply(5, 3)        # => 15
p multiply(2, 4)        # => 8
p multiply(0, 10)       # => 0
p multiply(-3, -6)      # => 18
p multiply(3, -6)       # => -18
p multiply(-3, 6)       # => -18
