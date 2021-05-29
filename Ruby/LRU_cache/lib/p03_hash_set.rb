class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return if include?(key)
    resize! if @count >= num_buckets
    bucket = key.hash % num_buckets
    @count+=1
    @store[bucket] << key
  end

  def include?(key)
    return @store[key.hash % num_buckets].include?(key)
  end

  def remove(key)
    return unless include?(key)
    bucket = key.hash % num_buckets
    @count-=1
    @store[bucket].delete key
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
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    items.each{|e| insert(e)}
  end
end
