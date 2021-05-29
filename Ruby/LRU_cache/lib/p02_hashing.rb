class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    hash = 0
    self.each_with_index{|e,i| hash ^= i.hash + e.hash}
    hash
  end
end

class String
  def hash
    hash = 0
    self.each_char.with_index{|e,i| hash ^= i.hash + e.ord.hash}
    hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash = 0
    self.each{|k,v| hash ^= k.hash + v.hash}
    hash
  end
end