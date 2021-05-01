class Player
    def get_move
        puts "enter a position with coordinates separated with a space like `4 7`"
        return gets.chomp.split(' ').map{|e| e.to_i}
    end
    
end
