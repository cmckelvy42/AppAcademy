require "byebug"
def strange_sums(nums)
    count = 0
    nums.each {|n| count += 1 if n > 0 && nums.include?(n * -1)}
    return count
end

def pair_product(nums, prod)
    for i in 0...nums.size
        for j in i + 1...nums.size
            return true if nums[i] * nums[j] == prod
        end
    end
    return false
end

def rampant_repeats(str, hash)
    ret = ""
    str.each_char{|c| hash[c] ? ret << (c * hash[c]) : ret << c }
    ret
end

def perfect_square?(num)
    for i in 1..num
        return true if i * i == num
    end
    return false
end

def anti_prime?(n)
    nFacts = count_factors(n)
    for i in 1...n
        return false if count_factors(i) >= nFacts
    end
    return true

end

def count_factors(n)
    ret = 0
    for i in 1..n
        ret += 1 if n % i == 0
    end
    return ret
end

def get_factors(n)
    ret = []
    for i in 1..n
        ret << i if n % i == 0
    end
    return ret
end



def matrix_addition(m1, m2)
    ret = Array.new(m1.size){[0] * m1[0].size}
    for i in 0...m1.size
        for j in 0...ret[i].size
            ret[i][j] = m1[i][j] + m2[i][j]
        end
    end
    return ret
end

def mutual_factors(*nums)
    ret = get_factors(nums[0])
    nums.each {|n| ret &= get_factors(n)}
    ret
end

def tribonacci_number(n)
    return 1 if n <= 2
    return 2 if n == 3
    return tribonacci_number(n - 1) + tribonacci_number(n - 2) + tribonacci_number(n - 3)
end
def matrix_addition_reloaded(*m)
    matrix = m.first
    height = matrix.size
    width = matrix.first.size
    m.inject do |a, m2|
        return nil if m2.length != height || m2[0].length != width
        matrix_addition(a, m2)
    end
end

def squarocol?(m)
    return true if m.any?{|r| r.uniq.length == 1}
    return true if m.transpose.any?{|c| c.uniq.length == 1}
    return false
end

def squaragonal?(m)
    diag1 = []
    diag2 = []
    for i in 0...m.size
        j = m.size - 1 - i
        diag1 << m[i][i]
        diag2 << m[i][j]
    end
    return diag1.uniq.size == 1 || diag2.uniq.size == 1
end

def pascals_triangle(n)
    triangle = []
    for i in 0...n
        row = []
        for j in 0..i
            if j == 0 || j == i
                row << 1 
            else
                row << triangle[i - 1][j] + triangle[i - 1][j - 1]
            end
        end
        triangle << row
    end
    triangle
end

def is_prime?(n)
    return false if n < 2
    for i in 2...n
        return false if n % i == 0
    end
    return true
end

def mersenne_prime(n)
    count = 0
    ret = 0
    i = 2
    while count < n
        if is_prime?((2**i) - 1)
            count += 1
            ret = (2**i) - 1
        end
        i += 1
    end
    ret
end

def triangular_number?(n)
    last = 0
    i = 0
    while last < n
        return true if last + i == n
        last += i
        i += 1
    end
    return false
end

def triangular_word?(word)
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    num = word.split('').inject(0){|a, c| a += alphabet.index(c) + 1}
    return triangular_number?(num)
end

def consecutive_collapse(arr)
    ret = arr.clone
    deletion = true
    while deletion 
        deletion = false
        for i in 0...ret.size - 1
            if (ret[i] - ret[i + 1]).abs == 1
                ret.delete_at(i)
                ret.delete_at(i)
                deletion = true
                break
            end
        end
    end
    return ret
end

def pretentious_primes(arr, n)
    ret = []
    return arr.clone if n == 0
    arr.each do |e|
        if n > 0
            count = 0
            while count < n
                e += 1
                count += 1 if is_prime?(e)
            end
            ret << e
        else
            count = 0
            while count < n.abs && e > 2
                e -= 1
                count += 1 if is_prime?(e)
            end
            count == n.abs ? ret << e : ret << nil
        end
    end
    ret
end
p strange_sums([2, -3, 3, 4, -2])     # 2
p strange_sums([42, 3, -1, -42])      # 1
p strange_sums([-5, 5])               # 1
p strange_sums([19, 6, -3, -20])      # 0
p strange_sums([9])                   # 0
puts "\n"
p pair_product([4, 2, 5, 8], 16)    # true
p pair_product([8, 1, 9, 3], 8)     # true
p pair_product([3, 4], 12)          # true
p pair_product([3, 4, 6, 2, 5], 12) # true
p pair_product([4, 2, 5, 7], 16)    # false
p pair_product([8, 4, 9, 3], 8)     # false
p pair_product([3], 12)             # false
puts "\n"
p rampant_repeats('taco', {'a'=>3, 'c'=>2})             # 'taaacco'
p rampant_repeats('feverish', {'e'=>2, 'f'=>4, 's'=>3}) # 'ffffeeveerisssh'
p rampant_repeats('misisipi', {'s'=>2, 'p'=>2})          # 'mississippi'
p rampant_repeats('faarm', {'e'=>3, 'a'=>2})            # 'faaaarm'
puts "\n"
p perfect_square?(1)     # true
p perfect_square?(4)     # true
p perfect_square?(64)    # true
p perfect_square?(100)   # true
p perfect_square?(169)   # true
p perfect_square?(2)     # false
p perfect_square?(40)    # false
p perfect_square?(32)    # false
p perfect_square?(50)    # false
puts "\n"
p anti_prime?(24)   # true
p anti_prime?(36)   # true
p anti_prime?(48)   # true
p anti_prime?(360)  # true
p anti_prime?(1260) # true
p anti_prime?(27)   # false
p anti_prime?(5)    # false
p anti_prime?(100)  # false
p anti_prime?(136)  # false
p anti_prime?(1024) # false
puts "\n"
matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]
p matrix_addition(matrix_a, matrix_b) # [[11, 6], [7, 7]]
p matrix_addition(matrix_a, matrix_c) # [[1, 5], [4, 6]]
p matrix_addition(matrix_b, matrix_c) # [[8, 1], [3, -1]]
p matrix_addition(matrix_d, matrix_e) # [[2, -5], [19, 14], [6, 4]]
puts "\n"
p mutual_factors(50, 30)            # [1, 2, 5, 10]
p mutual_factors(50, 30, 45, 105)   # [1, 5]
p mutual_factors(8, 4)              # [1, 2, 4]
p mutual_factors(8, 4, 10)          # [1, 2]
p mutual_factors(12, 24)            # [1, 2, 3, 4, 6, 12]
p mutual_factors(12, 24, 64)        # [1, 2, 4]
p mutual_factors(22, 44)            # [1, 2, 11, 22]
p mutual_factors(22, 44, 11)        # [1, 11]
p mutual_factors(7)                 # [1, 7]
p mutual_factors(7, 9)              # [1]
puts "\n"
p tribonacci_number(1)  # 1
p tribonacci_number(2)  # 1
p tribonacci_number(3)  # 2
p tribonacci_number(4)  # 4
p tribonacci_number(5)  # 7
p tribonacci_number(6)  # 13
p tribonacci_number(7)  # 24
p tribonacci_number(11) # 274
puts "\n"

p matrix_addition_reloaded(matrix_a, matrix_b)              # [[11, 6], [7, 7]]
p matrix_addition_reloaded(matrix_a, matrix_b, matrix_c)    # [[10, 6], [7, 6]]
p matrix_addition_reloaded(matrix_e)                        # [[0, 0], [12, 4], [6, 3]]
p matrix_addition_reloaded(matrix_d, matrix_e)              # [[2, -5], [19, 14], [6, 4]]
p matrix_addition_reloaded(matrix_a, matrix_b, matrix_e)    # nil
p matrix_addition_reloaded(matrix_d, matrix_e, matrix_c)    # nil
puts "\n"
p squarocol?([
    [:a, :x , :d],
    [:b, :x , :e],
    [:c, :x , :f],
]) # true

p squarocol?([
    [:x, :y, :x],
    [:x, :z, :x],
    [:o, :o, :o],
]) # true

p squarocol?([
    [:o, :x , :o],
    [:x, :o , :x],
    [:o, :x , :o],
]) # false

p squarocol?([
    [1, 2, 2, 7],
    [1, 6, 6, 7],
    [0, 5, 2, 7],
    [4, 2, 9, 7],
]) # true

p squarocol?([
    [1, 2, 2, 7],
    [1, 6, 6, 0],
    [0, 5, 2, 7],
    [4, 2, 9, 7],
]) # false

puts "\n"

p squaragonal?([
    [:x, :y, :o],
    [:x, :x, :x],
    [:o, :o, :x],
]) # true

p squaragonal?([
    [:x, :y, :o],
    [:x, :o, :x],
    [:o, :o, :x],
]) # true

p squaragonal?([
    [1, 2, 2, 7],
    [1, 1, 6, 7],
    [0, 5, 1, 7],
    [4, 2, 9, 1],
]) # true

p squaragonal?([
    [1, 2, 2, 5],
    [1, 6, 5, 0],
    [0, 2, 2, 7],
    [5, 2, 9, 7],
]) # false
puts "\n"
p pascals_triangle(5)
# [
#     [1],
#     [1, 1],
#     [1, 2, 1],
#     [1, 3, 3, 1],
#     [1, 4, 6, 4, 1]
# ]

p pascals_triangle(7)
# [
#     [1],
#     [1, 1],
#     [1, 2, 1],
#     [1, 3, 3, 1],
#     [1, 4, 6, 4, 1],
#     [1, 5, 10, 10, 5, 1],
#     [1, 6, 15, 20, 15, 6, 1]
# ]
puts "\n"
p mersenne_prime(1) # 3
p mersenne_prime(2) # 7
p mersenne_prime(3) # 31
p mersenne_prime(4) # 127
p mersenne_prime(6) # 131071
puts "\n"
p triangular_word?('abc')       # true
p triangular_word?('ba')        # true
p triangular_word?('lovely')    # true
p triangular_word?('question')  # true
p triangular_word?('aa')        # false
p triangular_word?('cd')        # false
p triangular_word?('cat')       # false
p triangular_word?('sink')      # false
puts "\n"
p consecutive_collapse([3, 4, 1])                     # [1]
p consecutive_collapse([1, 4, 3, 7])                  # [1, 7]
p consecutive_collapse([9, 8, 2])                     # [2]
p consecutive_collapse([9, 8, 4, 5, 6])               # [6]
p consecutive_collapse([1, 9, 8, 6, 4, 5, 7, 9, 2])   # [1, 9, 2]
p consecutive_collapse([3, 5, 6, 2, 1])               # [1]
p consecutive_collapse([5, 7, 9, 9])                  # [5, 7, 9, 9]
p consecutive_collapse([13, 11, 12, 12])              # []
puts "\n"

p pretentious_primes([4, 15, 7], 1)           # [5, 17, 11]
p pretentious_primes([4, 15, 7], 2)           # [7, 19, 13]
p pretentious_primes([12, 11, 14, 15, 7], 1)  # [13, 13, 17, 17, 11]
p pretentious_primes([12, 11, 14, 15, 7], 3)  # [19, 19, 23, 23, 17]
p pretentious_primes([4, 15, 7], -1)          # [3, 13, 5]
p pretentious_primes([4, 15, 7], -2)          # [2, 11, 3]
p pretentious_primes([2, 11, 21], -1)         # [nil, 7, 19]
p pretentious_primes([32, 5, 11], -3)         # [23, nil, 3]
p pretentious_primes([32, 5, 11], -4)         # [19, nil, 2]
p pretentious_primes([32, 5, 11], -5)         # [17, nil, nil]