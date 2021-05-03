def is_prime?(n)
    return false if n < 2
    for i in 2...n
        return false if n % i == 0
    end
    return true
end

def nth_prime(n)
    count = 0
    i = 2
    while count < n
        count += 1 if is_prime?(i)
        i += 1
    end
    return i - 1
end

def prime_range(min, max)
    ret = []
    for i in min..max
        ret << i if is_prime?(i)
    end
    return ret
end