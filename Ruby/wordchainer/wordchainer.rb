require "set"
class WordChainer
    def self.loadDictionary
        file = File.new("dictionary.txt")
        words = file.readlines.map(&:chomp)
        file.close
        return Set.new(words)
    end

    def initialize
        @dictionary = WordChainer.loadDictionary
    end

    def adjacent_words(word)
        ret = []
        alphabet = "abcdefghijklmnopqrstuvwxyz"
        for i in 0...word.size
            l = word[i]
            for j in 0..26
                letterloc = alphabet.index(l)
                tmpWord = word[0...i] + alphabet[(letterloc + j) % 26] + word[i + 1..-1]
                ret << tmpWord if @dictionary.include?(tmpWord) && tmpWord != word
            end
        end
        ret
    end

    def run(source, target)
        @current_words = [source]
        @all_seen_words = {source => nil}
        while @current_words.size > 0 && !@all_seen_words.include?(target)
            new_current_words = explore_current_words
            @current_words = new_current_words
        end
        p build_path(target).join(" -> ")
    end

    def build_path(target)
        currentWord = target
        ret = []
        while currentWord
            ret << currentWord
            currentWord = @all_seen_words[currentWord]
        end
        return ret.reverse
    end

    def explore_current_words
        ret = []
        @current_words.each do |w| 
            adjacent_words(w).each do |aw|
                 if !@all_seen_words.include?(aw)
                    ret << aw 
                    @all_seen_words[aw] = w
                 end
            end
        end
        ret
    end
end

WordChainer.new.run("harper", "market")