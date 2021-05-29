require_relative "board"
class Game
    def initialize(width, height, numMines)
        @board = Board.new(width, height, numMines)
        @over = false
    end

    def play
        while !@over
            @board.render
            puts "Select an action (Reveal/Flag)"
            action = gets.chomp
            case action.downcase
            when "reveal"
                reveal
            when "flag"
                flag
            else 
                "Invalid action"
            end
        end
    end

    def reveal
        revealed = 0
        while revealed == 0
            puts "What square do you want to reveal? (X,Y)"
            location = gets.chomp.split(',')
            location.map!{|e| e.to_i}
            revealed = @board.reveal(location)
            case revealed
            when -1
                @board.render
                puts "You lose!"
                @over = true
            when 0
                "Invalid location"
            end
        end
    end

    def flag
        flagged = 0
        while flagged == 0
            puts "What square do you want to flag? (X,Y)"
            location = gets.chomp.split(',')
            location.map!{|e| e.to_i}
            flagged  = @board.flag(location)
            case flagged
            when 1
                puts "#{location} has been flagged"
            when 0
                puts "Invalid location"
            when -1
                puts "#{location} has been unflagged"
            end
        end
    end
end

Game.new(9,9,10).play