def bi_prime?(num)
    prime_factors = (2...num).select{|n| num % n == 0 && prime?(n)}
    prime_factors.each{|n| return true if prime_factors.include?(num / n)}
    return false
end

def prime?(num)
    return false if num < 2
    (2...num).each {|factor| return false if num % factor == 0 }
    return true
end

p bi_prime?(14)   # => true
p bi_prime?(22)   # => true
p bi_prime?(25)   # => true
p bi_prime?(94)   # => true
p bi_prime?(24)   # => false
p bi_prime?(64)   # => false