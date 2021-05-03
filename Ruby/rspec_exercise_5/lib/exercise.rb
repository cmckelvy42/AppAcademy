require "byebug"
def zip(*arrs)
    size = arrs[0].size
    arrs.each{|a| raise "mismatched sizes" if a.size != size}
    ret = Array.new(size){Array.new}
    for i in 0...size
        arrs.each{|a| ret[i] << a[i]}
    end
    ret
end

def prizz_proc(arr, prc1, prc2)
    return arr.select{|e| prc1.call(e) != prc2.call(e)}
end

def zany_zip(*arrs)
    size = arrs.inject(0){|a, e| a = e.size > a ? e.size : a}
    ret = Array.new(size){Array.new}
    for i in 0...size
        arrs.each{|a| ret[i] << a[i]}
    end
    ret
end

def maximum(arr, &prc)
    return nil if arr.size == 0
    ret = arr[0]
    max = prc.call(arr[0])
    arr.each do |e|
        result = prc.call(e)
        if result >= max
            max = result
            ret = e
        end
    end
    ret
end

def my_group_by(arr, &prc)
    ret = Hash.new{|h, k| h[k] = []}
    arr.each{|e| ret[prc.call(e)] << e}
    ret
end

def max_tie_breaker(arr, proc, &block)
    return nil if arr.empty?
    blockResult = my_group_by(arr, &block)
    blockResult = blockResult[blockResult.keys.max]
    return blockResult.first if blockResult.size == 1
    procResult = my_group_by(blockResult, &proc)
    procResult = procResult[procResult.keys.max]
    return procResult.first
end

def silly_syllables(sent)
    vowels = "aeiou"
    words = sent.split(" ")
    words.each.with_index do |w, i|
        first = -1
        last = -1
        for j in 0...w.size
            first = j if vowels.include?(w[j]) && first < 0
            last = j if vowels.include?(w[j]) 
        end
        words[i] = w[first..last] if first != last
    end
    words.join(' ')
end