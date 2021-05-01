def palindrome?(str)
    mid = str.size / 2
    if str.size % 2 == 0
        return str[0...mid] == reverse(str[mid..-1])
    else
        return str[0..mid] == reverse(str[mid..-1])
    end
end

def reverse(str)
    ret = ""
    while str.size > 0 
        ret += str.slice!(-1)
    end
    return ret
end

def substrings(str)
    ret = []
    for i in 0...str.size
        for j in i...str.size
            ret << str[i..j]
        end
    end
    return ret
end

def palindrome_substrings(str)
    substr = substrings(str)
    ret = []
    substr.each do |s|
        ret << s if palindrome?(s) && s.length > 1
    end
    return ret
end