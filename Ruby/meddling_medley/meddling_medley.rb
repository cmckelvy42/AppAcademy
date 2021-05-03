require "byebug"
def duos(str)
    count = 0
    for i in 0...str.size
        count += 1 if str[i] == str[i + 1]
    end
    return count
end

def sentence_swap(sent, hash)
    ret = []
    sent.split(' ').each{|w| hash[w] ? ret << hash[w] : ret << w }
    return ret.join(' ')
end

def hash_mapped(hash, prc, &block)
    ret = {}
    hash.each{|k, v| ret[block.call(k)] = prc.call(v)}
    ret
end

def counted_characters(str)
    ret = []
    str.split("").uniq.each{|c| ret << c if str.count(c) > 2}
    ret
end

def triplet_true?(str)
    for i in 0...str.size - 2
        return true if str[i] == str[i + 1] && str[i] == str[i + 2]
    end
    return false
end

def energetic_encoding(str, hash)
    ret = ""
    str.split('').each{|c| c == ' ' ? ret << c : hash[c] ? ret << hash[c] : ret << '?'}
    return ret
end

def uncompress(str)
    ret = ""
    for i in 0...str.size
        ret << str[i] * str[i + 1].to_i
        i += 1
    end
    ret
end

def conjunct_select(arr, *prcs)
    ret = []
    arr.each do |e|
        count = 0
        prcs.each {|p| p.call(e) ? count += 1 : break}
        ret << e if count == prcs.size
    end
    ret
end

def convert_pig_latin(str)
    vowels = "aeiou"
    words = str.split(' ')
    ret = []
    words.each do |w|
        if w.size < 3
            ret << w
        elsif vowels.include?(w[0].downcase)
            ret << w + "yay"
        else
            tmp = w.split('')
            while !vowels.include?(tmp[0].downcase)
                tmp << tmp.shift
            end
            w == w.capitalize ? tmp = tmp.join('').capitalize : tmp = tmp.join('')
            ret << tmp + "ay"
        end
    end
    return ret.join(' ')
end

def reverberate(str)
    words = str.split(' ')
    vowels = "aeiouAEIOU"
    ret = []
    words.each do |w|
        if w.size < 3
            ret << w
        elsif vowels.include?(w[-1])
            ret << w + w
            
        else
            last_vowel_index = 0
            w.each_char.with_index{|c, i| last_vowel_index = i if vowels.include?(c)}
            ret << w + w[last_vowel_index..-1]
        end
        ret[-1] = ret[-1].capitalize if w == w.capitalize
    end
    return ret.join(' ')
end
p duos('bootcamp')      # 1
p duos('wxxyzz')        # 2
p duos('hoooraay')      # 3
p duos('dinosaurs')     # 0
p duos('e')             # 0

puts "\n"

p sentence_swap('anything you can do I can do',
    'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
) # 'nothing you shall drink I shall drink'
p sentence_swap('what a sad ad',
    'cat'=>'dog', 'sad'=>'happy', 'what'=>'make'
) # 'make a happy ad'
p sentence_swap('keep coding okay',
    'coding'=>'running', 'kay'=>'pen'
) # 'keep running okay'

puts "\n"

double = Proc.new { |n| n * 2 }
p hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' }
# {"A!!"=>8, "X!!"=>14, "C!!"=>-6}
first = Proc.new { |a| a[0] }
p hash_mapped({-5=>['q', 'r', 's'], 6=>['w', 'x']}, first) { |n| n * n }
# {25=>"q", 36=>"w"}

puts "\n"

p counted_characters("that's alright folks") # ["t"]
p counted_characters("mississippi") # ["i", "s"]
p counted_characters("hot potato soup please") # ["o", "t", " ", "p"]
p counted_characters("runtime") # []

puts "\n"

p triplet_true?('caaabb')        # true
p triplet_true?('terrrrrible')   # true
p triplet_true?('runninggg')     # true
p triplet_true?('bootcamp')      # false
p triplet_true?('e')             # false

puts "\n"

p energetic_encoding('sent sea',
    'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
) # 'zimp ziu'
p energetic_encoding('cat',
    'a'=>'o', 'c'=>'k'
) # 'ko?'
p energetic_encoding('hello world',
    'o'=>'i', 'l'=>'r', 'e'=>'a'
) # '?arri ?i?r?'
p energetic_encoding('bike', {}) # '????'

puts "\n"

p uncompress('a2b4c1') # 'aabbbbc'
p uncompress('b1o2t1') # 'boot'
p uncompress('x3y1x2z4') # 'xxxyxxzzzz'

puts "\n"

is_positive = Proc.new { |n| n > 0 }
is_odd = Proc.new { |n| n.odd? }
less_than_ten = Proc.new { |n| n < 10 }

p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) # [4, 8, 11, 7, 13]
p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd) # [11, 7, 13]
p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten) # [7]

puts "\n"

p convert_pig_latin('We like to eat bananas') # "We ikelay to eatyay ananasbay"
p convert_pig_latin('I cannot find the trash') # "I annotcay indfay ethay ashtray"
p convert_pig_latin('What an interesting problem') # "Atwhay an interestingyay oblempray"
p convert_pig_latin('Her family flew to France') # "Erhay amilyfay ewflay to Ancefray"
p convert_pig_latin('Our family flew to France') # "Ouryay amilyfay ewflay to Ancefray"

puts "\n"

p reverberate('We like to go running fast') # "We likelike to go runninging fastast"
p reverberate('He cannot find the trash') # "He cannotot findind thethe trashash"
p reverberate('Pasta is my favorite dish') # "Pastapasta is my favoritefavorite dishish"
p reverberate('Her family flew to France') # "Herer familyily flewew to Francefrance"