require "byebug"
class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }
  attr_reader :pegs

  def self.valid_pegs?(pegs)
    pegs.all? { |char| POSSIBLE_PEGS.has_key?(char.upcase)}
  end

  def initialize(pegs)
    if Code.valid_pegs?(pegs)
      @pegs = pegs.map{|c| c.upcase}
    else
      raise "Invalid pegs"
    end
  end

  def self.random(num)
    pegs = []
    for i in 0...num
      pegs << POSSIBLE_PEGS.keys.sample
    end
    return Code.new(pegs)
  end

  def self::from_string(pegs)
    return Code.new(pegs.split(''))
  end

  def [](i)
    return pegs[i]
  end

  def length
    return pegs.length
  end

  def num_exact_matches(code)
    count = 0
    for i in 0...code.length
      count += 1 if @pegs[i] == code[i]
    end
    return count
  end

  def num_near_matches(code)
    count = 0

   for i in 0...code.length
    count += 1 if code[i] != self[i] && @pegs.include?(code[i])
   end
    return count
  end

  def ==(rhs)
    return @pegs == rhs.pegs
  end

end
