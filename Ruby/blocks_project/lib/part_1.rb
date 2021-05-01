def select_even_nums(arr)
    return arr.select(&:even?)
end

def reject_puppies(arr)
    return arr.reject{|e| e["age"] <= 2}
end

def count_positive_subarrays(arr)
    arr.count{|e| e.sum > 0}
end

def aba_translate(str)
    vowels = "aeiou"
    ret = ""
    str.each_char do |c|
        if vowels.include?(c.downcase)
            ret << c + 'b' + c
        else
            ret << c
        end
    end
    return ret
end

def aba_array(words)
    words.map{|word| aba_translate(word)}
end