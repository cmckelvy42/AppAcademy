require_relative "board"
require_relative "display"
require_relative "human_player"
COLORS = [:light_yellow, :black].freeze
class Game
    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players = {light_yellow: HumanPlayer.new(@display), black: HumanPlayer.new(@display)}
        @current_turn = :light_yellow
    end

    def play
        until COLORS.any?{|e| @board.checkmate?(e)}
            begin

                @display.clear_check
                @display.notifications[:check] = @current_turn if @board.check?(@current_turn)
                start_pos, end_pos = @players[@current_turn].take_turn
                @board.move_piece(@current_turn, start_pos, end_pos)
                swap_turn
            rescue StandardError => e
                require "byebug"
                debugger
                @display.notifications[:error] = e.message
                retry
            end
        end
        @display.render
        puts "#{@current_turn} is checkmated!"
    end
    def swap_turn
        @current_turn = COLORS[(COLORS.index(@current_turn) + 1) % 2]
    end

end