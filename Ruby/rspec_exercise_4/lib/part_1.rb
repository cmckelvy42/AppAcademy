def my_reject(arr, &prc)
    return arr.select{|e| prc.call(e) == false}
end

def my_one?(arr, &prc)
    flag = false
    arr.each do |e|
        return false if flag == true && prc.call(e) == true
        flag = true if prc.call(e) == true && flag == false
    end
    return flag
end

def hash_select(hash, &prc)
    ret = {}
    hash.each{|k, v| ret[k] = v if prc.call(k, v)}
    return ret
end

def xor_select(arr, prc1, prc2)
    return arr.select{|e| prc1.call(e) != prc2.call(e)}
end

def proc_count(value, procs)
    count = 0
    procs.each {|p| count += 1 if p.call(value)}
    return count
end

def proper_factors(n)
    ret = []
    for i in 1...n
        ret << i if n % i == 0
    end
    ret
end

def aliquot_sum(n)
    return proper_factors(n).inject{|a, e| a += e}
end

def perfect_number?(n)
    return n == aliquot_sum(n)
end

def ideal_numbers(n)
    ret = []
    i = 1
    while ret.size < n
        ret << i if perfect_number?(i)
        i += 1
    end
    ret
end