require_relative 'board'
require_relative 'player'

class ConnectTacToe

    def initialize(numStacks, maxHeight)
        @board = Board.new(numStacks, maxHeight)
        @player_1 = Player.new('y')
        @player_2 = Player.new('b')
        @current_player = @player_1
    end
    # This ConnectTacToe#play method is given for free and does not need to be modified
    # It is used to make your game playable.
    def play
        until @board.winner?(@player_1.token) || @board.winner?(@player_2.token)
            @board.print
            self.play_turn
            p "--------------------"
        end

        self.switch_players!
        @board.print
        p @current_player.token + " has won!"
    end

    def switch_players!
        @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
    end

    def play_turn
        stack = gets.chomp.to_i
        @board.add(@current_player.token, stack)
        switch_players!
    end
end
