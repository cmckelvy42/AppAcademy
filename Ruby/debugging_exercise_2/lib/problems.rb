# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

require "byebug"
def largest_prime_factor(num)
    ret =  1
    for i in 2..num
        ret = i if num % i == 0 && prime?(i)
    end
    return ret
end

def prime?(num)
    for i in 2...num
        return false if num % i == 0
    end
    return true
end

def unique_chars?(str)
    map = Hash.new 0
    str.each_char do |c|
        map[c] += 1
        return false if map[c] > 1
    end
    return true
end

def dupe_indices(arr)
    ret = Hash.new {|h, k| h[k] = []}
    arr.each_with_index{|x, i| ret[x] << i}
    return ret.select{|k, v| v.length > 1}
end

def ana_array(arr1, arr2)
    map1 = Hash.new 0
    map2 = Hash.new 0
    arr1.each {|e| map1[e] += 1}
    arr2.each {|e| map2[e] += 1}
    return map1 == map2
end