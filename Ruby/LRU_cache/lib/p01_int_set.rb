require "byebug"
class MaxIntSet
  attr_reader :store, :max
  def initialize(max)
    @max = max
    @store = Array.new(max+1){|e| e = false}
  end

  def insert(num)
    raise "Out of bounds" if num > @max || num < 0
    @store[num] = true
  end

  def remove(num)
    raise "Out of bounds" if num > @max || num < 0
    @store[num] = false
  end

  def include?(num)
    raise "Out of bounds" if num > @max || num < 0
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = num % @store.size
    @store[bucket] << num unless @store[bucket].include?(num)
  end

  def remove(num)
    bucket = num % @store.size
    @store[bucket].delete num if @store[bucket].include?(num)
  end

  def include?(num)
    return @store[num % @store.size].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    return if include?(num)
    resize! if @count >= @num_buckets
    bucket = num % @num_buckets
    @count+=1
    @store[bucket] << num
  end

  def remove(num)
    return unless include?(num)
    bucket = num % @num_buckets
    @count-=1
    @store[bucket].delete num
  end

  def include?(num)
    bucket = num % @num_buckets
    @store[bucket].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    items = @store.flatten
    @num_buckets*=2
    @store = Array.new(@num_buckets) { Array.new }
    @count = 0
    items.each{|e| insert(e)}
  end
end