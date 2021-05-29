require_relative "tile"
class Board
    def self.empty_grid(w, h)
        return Array.new(h){Array.new(w){Tile.new}}
    end
    def initialize(width, height, numMines)
        @grid = Board.empty_grid(width, height)
        @size = 9 * 9
        @num_mines = numMines
        place_random_mines(numMines)
        populate_adjacents
    end

    def place_random_mines(n)
        minesLeft = n
        while minesLeft > 0
            y = rand(@grid.size)
            x = rand(@grid[y].size)
            if @grid[y][x] != :X
                @grid[y][x].value = :X 
                minesLeft -= 1
            end
        end
    end

    def populate_adjacents
        for y in 0...@grid.size
            for x in 0...@grid[y].size
                @grid[y][x].setAdjacents(numAdjacentMines(x,y))
            end
        end
    end

    def render
        puts "  " + (0...@grid[0].size).to_a.join(' ')
        @grid.each_with_index do |r, i|
            print "#{i} "
            row = []
            r.each{|e| row << (e.revealed ? e.value : e.flagged ? :F : '_')}
            puts row.join(' ')
        end
    end

    def reveal(location)
        x,y = location
        return 0 if @grid[y][x].revealed || @grid[y][x].flagged
        if @grid[y][x] == :X
            @grid[y][x].reveal
            return -1 
        end
        reveal_area(x, y) if @grid[y][x].numAdjacent == 0
        @grid[y][x].reveal
        return 1
    end

    def reveal_area(x, y)
        return if @grid[y][x].revealed
        return if @grid[y][x].value == :X
        if @grid[y][x].numAdjacent > 0
            @grid[y][x].reveal
            return
        end
        @grid[y][x].reveal
        queue = []
        ymin = [0,y-1].max
        xmin = [0,x-1].max
        xmax = [@grid[y].size - 1, x + 1].min
        ymax = [@grid.size - 1, y + 1].min
        for i in ymin..ymax
            for j in xmin..xmax
                next if i == y && j == x
                if @grid[i][j].revealed == false && @grid[i][j].value != :X
                    queue << [j,i]
                end
            end
        end
        queue.each{|e| reveal_area(*e)}
    end

    def numAdjacentMines(x,y)

        ret = 0
        ymin = [0,y-1].max
        xmin = [0,x-1].max
        xmax = [@grid[y].size - 1, x + 1].min
        ymax = [@grid.size - 1, y + 1].min
        for i in ymin..ymax
            for j in xmin..xmax
                next if i == y && j == x
                ret += 1 if @grid[i][j] == :X
            end
        end
        return ret
    end

    def flag(location)
        x,y = location
        @grid[y][x].toggle_flag
    end
end
