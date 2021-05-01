class Board
    attr_reader :size

    def self.print_grid(grid)
        grid.each {|row| puts row.join(' ')}
    end
    def initialize(n)
      @grid = Array.new(n){Array.new(n, :N)}
      @size = n*n
    end

    def [](pos)
      row, col = pos
      return @grid[row][col]
    end

    def []=(pos, val)
      row, col = pos
      @grid[row][col] = val
    end 

    def num_ships
      return @grid.inject(0){|a, e| a += e.count(:S)}
    end

    def attack(pos)
        if self[pos] == :S
            self[pos] = :H
            puts "you sunk my battleship!"
            return true
        end
        self[pos] = :X
        return false
    end

    def place_random_ships
        (size / 4).times do
            pos = [rand(@grid.size), rand(@grid.size)]
            while self[pos] == :S
                pos = [rand(@grid.size), rand(@grid.size)]
            end
            self[pos] = :S
        end
    end

    def hidden_ships_grid
        @grid.map{|row| row.map{|e| e == :S ? :N : e}}
    end 

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(hidden_ships_grid)
    end
    
end