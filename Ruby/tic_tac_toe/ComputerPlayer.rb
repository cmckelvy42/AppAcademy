require_relative "Player"

class ComputerPlayer < Player 
    def initialize(mark, number)
        super(mark, number)
        @marks = Hash.new
    end
    def random_move(legal_positions)
        i = rand(legal_positions.size)
        return legal_positions[i]
    end

end