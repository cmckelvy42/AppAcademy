def prime_factorization(num)
    for i in 2...num
        if num % i == 0
            j = num / i
            return prime_factorization(i) + prime_factorization(j)
        end
    end
    return [num]
end

p prime_factorization(12)     # => [2, 2, 3]
p prime_factorization(24)     # => [2, 2, 2, 3]
p prime_factorization(25)     # => [5, 5]
p prime_factorization(60)     # => [2, 2, 3, 5]
p prime_factorization(7)      # => [7]
p prime_factorization(11)     # => [11]
p prime_factorization(2017)   # => [2017]