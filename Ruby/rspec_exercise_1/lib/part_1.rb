def average(n1, n2)
    return (n1 + n2) / 2.0
end

def average_array(nums)
    return nums.sum / (nums.size * 1.0)
end

def repeat(str, n)
    return str * n
end

def yell(str)
    return str.upcase + '!'
end

def alternating_case(str)
    ret = []
    str.split(' ').each.with_index { |w, i| i % 2 == 0 ? ret << w.upcase : ret << w.downcase}
    return ret.join(' ')
end

