require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    return @store[key.hash % num_buckets].include?(key)
  end

  def set(key, val)
    if include?(key)
      bucket(key).update(key,val)
      return
    end
    resize! if @count >= num_buckets
    bucket = bucket(key)
    @count+=1
    bucket.append(key, val)
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    return unless include?(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each
    @store.each do |b|
      b.each{|l| yield [l.key, l.val]}
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    items = self.select{|e| e}
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0
    items.each{|k,v| set(k, v)}
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
