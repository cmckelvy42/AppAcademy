LETTERS = "abcdefghijklmnopqrstuvwxyz"
GHOST = "GHOST"
class Player
    attr_reader :letters
    def initialize
        @letters = ""
    end

    def take_turn
        letter = ""
        while letter.size != 1
            puts "Please add a letter"
            letter = gets.chomp
            letter = "" if letter.size != 1 || !LETTERS.include?(letter.downcase)
        end 
        return letter
    end

    def add_letter
        @letters << GHOST[@letters.size] if !lose?
    end

    def lose?
        return @letters.size == GHOST.size
    end

end