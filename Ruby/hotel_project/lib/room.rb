class Room
    def initialize(capacity)
        @capacity = capacity
        @occupants = Array.new(0)
    end
    
    def capacity
        return @capacity
    end
    def occupants
        return @occupants
    end
    def full? 
        return available_space == 0
    end
    def available_space
        return  @capacity - @occupants.size
    end
    def add_occupant(name)
        if full?
            return false
        else
            occupants << name
            return true
        end
    end
end
