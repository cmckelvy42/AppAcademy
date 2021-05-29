class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index{ |link, j| return link if i == j }
    nil
  end

  def first
    empty? ? nil : @head.next
  end

  def last
    empty? ? nil : @tail.prev
  end

  def empty?
    return @head.next == @tail
  end

  def get(key)
    self.each{|e| return e.val if e.key == key}
    nil
  end

  def get_node(key)
    self.each{|e| return e if e.key == key}
    nil
  end

  def include?(key)
    self.any?{|e| e.key == key}
  end

  def append(key, val)
    tmp = @tail.prev
    tmp.next = Node.new(key, val)
    @tail.prev = tmp.next
    last.prev = tmp
    last.next = @tail
  end

  def update(key, val)
    self.get_node(key).val = val if include?(key)
  end

  def remove(key)
    tmp = self.get_node(key)
    tmp.prev.next = tmp.next
    tmp.next.prev = tmp.prev
  end

  def each
    current = @head.next
    until current == @tail
      yield current
      current = current.next
    end
  end

  def to_s
     inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
