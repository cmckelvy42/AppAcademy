require_relative "player"
require "set"
RESPONSES = ["y", "n", "yes", "no"]
class Game
    def initialize(numplayers)
      @players = Array.new(numplayers){Player.new}
      
      file = File.open("dictionary.txt")
      words = file.readlines.map(&:chomp)
      file.close
      @dictionary = Set.new(words)
      @fragment = ""
    end

    def play_game
        i = 0
        while !over?
            while !valid_word
                if @players[i].lose?
                    i = (i + 1) % @players.size 
                    next
                end
                puts "Player #{i + 1}, your turn"
                @fragment << @players[i].take_turn
                puts "The fragment is now #{@fragment}"
                if !check_valid_fragment
                    i = (i + 1) % @players.size 
                    break
                end
                i = (i + 1) % @players.size 
            end
            @fragment = ""
            @players[i - 1].add_letter
            puts "Player #{i == 0 ? 3 : i} now has #{@players[i - 1].letters}"
        end
        game_over       
    end

    def over?
        count = 0
        @players.each{|p| count += 1 if !p.lose? }
        return count == 1
    end

    def valid_word
        if @dictionary.include?(@fragment)
            puts "#{@fragment} is a valid word"
            return true
        end
        return false
    end

    def check_valid_fragment
        @dictionary.each_entry{|w| return true if w[0...@fragment.size] == @fragment}
        puts "The word fragment is no longer valid"
        return false
    end
    def game_over
        i = 0
        while @players[i].lose?
            i += 1
        end
        puts "Player #{i + 1} wins!"
    end
end
playerCount = 0
while playerCount < 2
    puts "How many players?"
    playerCount = gets.chomp.to_i
    puts "Must have at least 2 players" if playerCount < 2
end
Game.new(playerCount).play_game