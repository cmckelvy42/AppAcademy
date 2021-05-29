def exp1(b, e)
    return 1 if e == 0
    return b if e == 1
    return b * exp1(b, e - 1)
end

def exp2(b, e)
    return 1 if e == 0
    return b if e == 1
    half = exp2(b, e / 2)
    e.even? ? half * half : b * half * half
end

class Array
    def deep_dup
        ret = []
        self.each do |e|
            e.is_a?(Array) ? ret << e.deep_dup : ret << e
        end
        ret
    end
end

def bsearch(arr, target)
    return nil if arr.size < 1
    mid = arr.size / 2

    case arr[mid] <=> target
    when -1
        subsolution = bsearch(arr.drop(mid + 1), target)
        subsolution.nil? ? nil : subsolution + mid + 1
    when 0
        return mid
    when 1
        return bsearch(arr.take(mid), target)
    end
end

class Array
    private def merge(arr1, arr2)
        ret = []
        while arr1.size > 0 && arr2.size > 0
            arr1[0] > arr2[0] ? ret << arr2.shift : ret << arr1.shift
        end
        ret + arr1 + arr2
    end

    def merge_sort
        return self if self.size <= 1
        half = self.size / 2
        left = self.take(half)
        right = self.drop(half)
        merge(left.merge_sort, right.merge_sort)
    end

    def subsets
        return [[]] if empty?
        subs = self.take(count - 1).subsets
        subs.concat(subs.map{|e| e + [self[-1]]})
    end
end

def permutations(arr)
    return [arr] if arr.size <= 1
    first = arr.shift
    perms = permutations(arr)
    ret = []
    perms.each do |perm|
        for i in 0..perm.size
            ret << perm[0...i] + [first]  + perm[i..-1]
        end
    end
    ret
end

def make_change(amt, coins = [25, 10, 5, 1])
    return [] if amt == 0
    possible_answers = []
    for i in 0...coins.size
        coin = coins[i]
        possible_answers << ([coin] + make_change(amt - coin, coins)) if coins[i] <= amt
    end
    ret = possible_answers[0]
    possible_answers.each{|e| ret = e if e.size < ret.size}
    ret
end

p exp1(3, 15)
p exp2(3, 15)

a = [1,[1,3,[2,5,7,8],246,5,[1,3],3],6,1,[7,9],1]
p a.deep_dup

p bsearch([1, 2, 3], 1) # => 0
p bsearch([2, 3, 4, 5], 3) # => 1
p bsearch([2, 4, 6, 8, 10], 6) # => 2
p bsearch([1, 3, 4, 5, 9], 5) # => 3
p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

p [1,6,9,5,4,2,8,3,7].merge_sort

p [1,2,3].subsets
p permutations([1,2,3])

p make_change(39)
p make_change(24, [10, 7, 1])