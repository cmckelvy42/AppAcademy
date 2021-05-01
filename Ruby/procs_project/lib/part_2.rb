def reverser(str, &prc)
    return prc.call(str.reverse)
end

def word_changer(str, &prc)
    words = str.split(' ')
    for i in 0...words.size
        words[i] = prc.call(words[i])
    end
    return words.join(' ')
end

def greater_proc_value(num, prc1, prc2)
    val1 = prc1.call(num)
    val2 = prc2.call(num)
    return val1 > val2 ? val1 : val2
end

def and_selector(arr, prc1, prc2)
    ret = []
    arr.each{|e| ret << e if prc1.call(e) && prc2.call(e)}
    return ret
end

def alternating_mapper(arr, prc1, prc2)
    ret = []
    arr.each_with_index{|e,i|ret.push(i % 2 == 0 ? prc1.call(e) : prc2.call(e))}
    return ret
end