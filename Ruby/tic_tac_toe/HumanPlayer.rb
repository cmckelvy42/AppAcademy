require_relative "Player"
class HumanPlayer < Player
    def get_position
        return gets.chomp.split(' ').map{|e| e.to_i - 1}
    end
end