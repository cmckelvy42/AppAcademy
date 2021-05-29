class Tile
    attr_accessor :value
    attr_reader :revealed, :numAdjacent, :flagged
    def initialize(value = '_')
        @value = value
        @revealed = false
        @flagged = false
        @numAdjacent = 0
    end

    def toggle_flag
        @flagged = !@flagged
    end

    def setAdjacents(val)
        @numAdjacent = val
    end

    def reveal
        @revealed = true
        @value = numAdjacent.to_s if @value == "_" && numAdjacent > 0
        @value = ' ' if @value == "_" && numAdjacent == 0
    end

    def !=(val)
        return @value != val
    end

    def ==(val)
        return @value == val
    end
end