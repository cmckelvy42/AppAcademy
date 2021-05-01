# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
    def span
        if self.size > 0
            return self.max - self.min
        end
        return nil
    end

    def average
        return nil if self.size == 0
        return self.sum / (self.size * 1.0)
    end
    
    def median
        sorted = self.sort
        return nil if self.size == 0
        mid = self.size / 2
        return sorted[mid] if self.size % 2 == 1
        return sorted[mid - 1..mid].average
    end  
    
    def counts
        ret = Hash.new 0
        self.each {|e| ret[e] += 1}
        return ret
    end

    def my_count(val)
        return counts[val]
    end

    def my_index(val)
        self.each_with_index {|e, i| return i if e == val}
        return nil
    end
    def my_uniq
        return self.counts.keys
    end

    def my_transpose
        ret = Array.new(self[0].size) {Array.new(self.size)}
        for i in 0...self[0].size
            for j in 0...self.size
                ret[i][j] = self[j][i]
            end
        end
        return ret
    end
end
