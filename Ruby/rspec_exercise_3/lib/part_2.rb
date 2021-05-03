def element_count(arr)
    ret = Hash.new 0
    arr.each {|e| ret[e] += 1}
    return ret
end

def char_replace!(str, hash)
    str.each_char.with_index{|c, i| str[i] = hash[c] if hash[c] != nil}
    return str
end

def product_inject(nums)
    return nums.inject{|a, e| a *= e}
end