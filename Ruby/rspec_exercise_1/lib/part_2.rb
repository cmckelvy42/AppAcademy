def hipsterfy(str)
    vowels = "aeiou"
    ret = str.reverse
    for i in 0...ret.size
        if vowels.include?(ret[i])
            ret.slice!(i) 
            break
        end
    end
    return ret.reverse
end

def vowel_counts(str)
    vowels = "aeiou"
    ret = Hash.new 0
    str.downcase.each_char {|c| ret[c] += 1 if vowels.include?(c)}
    return ret
end

def caesar_cipher(str, n)
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    ret = ""
    str.each_char do |c|
        if alphabet.include?(c.downcase)
            tmp = alphabet[(alphabet.index(c.downcase) + n) % 26]
            tmp = tmp.upcase if c == c.upcase
        else
            tmp = c
        end
        ret << tmp
    end
    return ret
end