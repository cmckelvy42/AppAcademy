class HumanPlayer
    def initialize(display)
        @display = display
    end

    def take_turn
        start_pos, end_pos = nil, nil
        until start_pos && end_pos
            
            @display.render

            if start_pos
                puts "Move to where?"
                end_pos = @display.get_input
                @display.clear_errors if end_pos
            else
                puts "Move which piece?"
                start_pos = @display.get_input
                @display.clear_errors if start_pos
            end
        
        end
        return [start_pos, end_pos]
    end
end