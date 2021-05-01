def longest_streak(str)
    ret = ""
     i = 0
    for i in 0...str.size
        j = i + 1
        while str[i] == str[j]
            j += 1
        end
        ret = str[i...j] if str[i...j].size >= ret.size
        i = j
    end
    return ret
end

p longest_streak('a')           # => 'a'
p longest_streak('accccbbb')    # => 'cccc'
p longest_streak('aaaxyyyyyzz') # => 'yyyyy
p longest_streak('aaabbb')      # => 'bbb'
p longest_streak('abc')         # => 'c'