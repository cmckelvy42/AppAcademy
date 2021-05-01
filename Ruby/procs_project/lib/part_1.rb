def my_map(arr, &prc)
    map = []
    arr.each {|e| map << prc.call(e)}
    return map
end

def my_select(arr, &prc)
    select = []
    arr.each{|e| select << e if prc.call(e)}
    return select
end

def my_count(arr, &prc)
    count = 0
    arr.each{|e| count += 1 if prc.call(e)}
    return count
end

def my_any?(arr, &prc)
    arr.each{|e| return true if prc.call(e)}
    return false
end

def my_all?(arr, &prc)
    arr.each{|e| return false unless prc.call(e)}
    return true
end

def my_none?(arr, &prc)
    arr.each{|e| return false unless !prc.call(e)}
    return true
end