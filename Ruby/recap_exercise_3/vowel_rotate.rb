def vowel_rotate(str)
    last = last_vowel(str)
    for i in 0...str.size
        if "aeiou".include?(str[i].downcase)
            tmp = last
            last = str[i]
            str[i] = tmp 
        end
    end
    return str
end

def last_vowel(str)
    str.reverse.each_char{|c| return c if "aeiou".include?(c.downcase)}
end

p vowel_rotate('computer')      # => "cempotur"
p vowel_rotate('oranges')       # => "erongas"
p vowel_rotate('headphones')    # => "heedphanos"
p vowel_rotate('bootcamp')      # => "baotcomp"
p vowel_rotate('awesome')       # => "ewasemo"