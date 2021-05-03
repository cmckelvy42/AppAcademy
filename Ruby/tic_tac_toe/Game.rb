require_relative "HumanPlayer"
require_relative "ComputerPlayer"
require_relative "Board"
require "byebug"

VALID_RESPONSES = ["yes", "y", "no", "n"]

class Game
    attr_reader :currentPlayer, :over
    def initialize(playerMarks, firstComputer = playerMarks.size)
        @over = true
        @marks = playerMarks
        @players = []
        @firstComputer = firstComputer
        humanPlayers = []
        computerPlayers = []
        
        for i in 0...firstComputer
            humanPlayers << HumanPlayer.new(playerMarks[i], i + 1)
        end
        for i in firstComputer...playerMarks.size
            computerPlayers << ComputerPlayer.new(playerMarks[i], i + 1)
        end
        @players = humanPlayers + computerPlayers
        size = 0
        while size < 3
            puts "What size board?"
            size = gets.chomp.to_i
            puts "Invalid size" if size < 3
        end
        @board = Board.new(size)
        @currentPlayer = 0
    end

    def switch_turn
        @currentPlayer = (@currentPlayer + 1) % @players.size
    end
    def attempt_place
        if @currentPlayer < @firstComputer
            puts "Player #{@currentPlayer + 1}, enter two numbers representing a position in the format \<row> <column>"
            position = @players[currentPlayer].get_position
            while !@board.place_mark(position, @marks[currentPlayer])
                puts "Invalid position"
                @board.print
                puts "Player #{@currentPlayer + 1}, enter two numbers representing a position in the format \<row> <column>"
                position = @players[currentPlayer].get_position
            end
        else
            legal_positions = @board.legal_positions
            legal_positions.each do |p|
                @board.place_mark(p, @marks[currentPlayer])
                return if @board.win?(@marks[currentPlayer])
                @board.clear_mark(p)
            end
            position = @players[currentPlayer].random_move(@board.legal_positions)
            @board.place_mark(position, @marks[currentPlayer])
            puts "Player #{@currentPlayer + 1} marked #{position[0]}, #{position[1]}"
        end
    end
    def play
        @over = false
        while !@marks.any?{|m| @board.win?(m)} && @board.empty_positions?
            @board.print
            attempt_place
            switch_turn
        end
        @over = true
        @board.print
        @marks.each_index{|i| return i if @board.win?(@marks[i])}
        return nil
    end
end