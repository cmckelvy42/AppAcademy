def partition(arr, n)
    ret = Array.new(2){Array.new}
    arr.each do |x|
        if x < n
            ret[0] << x
        else
            ret[1] << x
        end
    end
    return ret
end

def merge(h1, h2)
    return h1.merge(h2)
end

def censor(sent, filter)
    words = sent.split(' ')
    vowels = "aeiou"
    words.each_index do |i|
        words[i].each_char.with_index {|c, j| words[i][j] = '*' if vowels.include?(c.downcase)} if filter.include?(words[i].downcase)
    end
    return words.join(' ')
end

def power_of_two?(n)
    while n % 2 == 0
        n /= 2
    end
    return n == 1
end

p censor("SHUT THE FRONT DOOR", ["door"])