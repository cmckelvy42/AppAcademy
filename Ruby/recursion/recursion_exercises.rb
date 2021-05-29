require "byebug"
def range(n1, n2)
    return [] if n2 < n1
    return [n1] + range(n1 + 1, n2)
end

def exp1(b, n)
    n == 0 ? 1 : b * exp1(b, n-1)
end

def exp2(b, n)
    return 1 if n == 0
    return b if n == 1

    half = exp2(b, n / 2)
    if n.even? 
        return half * half
    else
        return b * half * half
    end
end

def deep_dup(arr)
    ret = []
    arr.each{|e| e.is_a?(Array) ? ret << deep_dup(e) : ret << e}
    ret
end

def bsearch(nums, target)
    return nil if nums.empty?
    half = nums.size / 2
    case nums[half] <=> target
    when 1
        return bsearch(nums.take(half), target)
    when 0
        return half
    when -1
        subanswer = bsearch(nums.drop(half + 1), target)
        subanswer.nil? ? nil : subanswer + half
    end
end

class Array
    def merge(arr1, arr2)
        ret = []
        while arr1.size > 0 && arr2.size > 0
            arr1[0] < arr2[0] ? ret << arr1.slice!(0) : ret << arr2.slice!(0)
        end
        arr1.size > 0 ? ret += arr1 : ret += arr2
        ret
    end

    def merge_sort
        return self if count < 2
        middle = count / 2
        left, right = self.take(middle), self.drop(middle)
        sorted_left, sorted_right = left.merge_sort, right.merge_sort

        merge(sorted_left, sorted_right)
    end
end

def permutations(arr)
    return [arr] if arr.length <= 1

    first = arr[0]
    perms = permutations(arr.drop(1))
    total_permutations = []
    perms.each do |perm|
        for i in 0..perm.size
            total_permutations << perm[0...i] + [first] + perm[i..-1]
        end
    end
    total_permutations
end
p range(5,5)

p 3 ** 20
p exp1(3, 20)
p exp2(3, 20)
p bsearch([1, 2, 3], 1) # => 0
p bsearch([2, 3, 4, 5], 3) # => 1
p bsearch([2, 4, 6, 8, 10], 6) # => 2
p bsearch([1, 3, 4, 5, 9], 5) # => 3
p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

p [1,6,4,7,3].merge_sort
p permutations([1,2,3])