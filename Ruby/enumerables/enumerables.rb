class Array
    def my_each(&prc)
        for i in 0...self.size
            prc.call(self[i])
        end
        return self
    end

    def my_select(&prc)
        ret = []
        my_each{|e| ret << e if prc.call(e)}
        return ret
    end

    def my_reject(&prc)
        ret = []
        my_each{|e| ret << e if !prc.call(e)}
        return ret
    end

    def my_any?(&prc)
        my_each{|e| return true if prc.call(e)}
        return false
    end

    def my_all?(&prc)
        my_each{|e| return false unless prc.call(e)}
        return true
    end

    def my_flatten
        ret = []
        my_each{|e| e.is_a?(Array) ? ret += e.flatten : ret << e}
        return ret
    end

    def my_zip(*arrs)
        ret = Array.new(self.size){|e| e = []}
        for i in 0...self.size
            ret[i] << self[i]
            arrs.my_each{|a| ret[i] << a[i]}
        end
        return ret
    end

    def my_rotate(n = 1)
        ret = Array.new(self.size)
        for i in 0...self.size
            ret[i] = self[(i + n) % self.size]
        end
        ret
    end

    def my_join(delim="")
        ret = ""
        parts = self.flatten
        parts.each_with_index{|e, i| i < parts.size - 1 ? ret << e + delim : ret << e}
        ret
    end

    def my_reverse
        ret = Array.new(self.size)
        for i in 0...self.size
            ret[-1 - i] = self[i]
        end
        ret
    end
end

 # calls my_each twice on the array, printing all the numbers twice.
 return_value = [1, 2, 3].my_each do |num|
    puts num
  end.my_each do |num|
    puts num
  end
  
  p return_value  # => [1, 2, 3]
  puts "\n"

a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []
puts "\n"

a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]
puts "\n"

a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true
puts "\n"

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]
puts "\n"

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]
puts "\n"

a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]
puts "\n"

a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"
puts "\n"

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
puts "\n"