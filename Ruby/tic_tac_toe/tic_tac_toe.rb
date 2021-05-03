
require_relative "Game"
def get_players
    playerCount = 0

    while playerCount < 2
        puts "How many players?"
        playerCount = gets.chomp.to_i
        puts "Must have at least 2 players" if playerCount < 2
    end
    return playerCount
end


def get_humans(playerCount)
    humanCount = 0
    while humanCount < 1
        puts "How many humans?"
        humanCount = gets.chomp.to_i
        humanCount = 0 if humanCount > playerCount
        puts "Must have 1-#{playerCount} human players"  if humanCount < 1 
    end
    return humanCount
end

def get_marks(playerCount, firstComputer = playerCount)
    playerMarks = []
    playerCount.times do |i|
        currentMark = nil
        while !currentMark
            if i < firstComputer
                puts "Player #{i + 1} please input your mark to use"
            else
                puts "Input mark for Player #{i + 1} (Computer)"
            end
            currentMark = gets.chomp
            if currentMark.size != 1
                currentMark = nil
                puts "Must be a single character"
            elsif playerMarks.include?(currentMark.upcase)
                puts "Someone already has that mark"
                currentMark = nil
            elsif currentMark == "_" || currentMark == " " || currentMark == "\t"
                puts "Invalid mark"
                currentMark = nil
            end
        end
        playerMarks << currentMark.upcase
    end
    return playerMarks
end

def play_game
    playerCount = get_players
    human_count = get_humans(playerCount)
    human_count < playerCount ? game = Game.new(get_marks(playerCount, human_count), human_count) : game = Game.new(get_marks(playerCount))
    return game.play
end

play_again = true
while play_again
    response = ""
    winner = play_game
    if winner
        puts "Player #{winner + 1} wins!"
    else
        puts "Draw!"
    end
    while response == ""
        puts "Play again? (yes/no)"
        response = gets.chomp
        response = "" if !VALID_RESPONSES.include?(response.downcase)
    end
    VALID_RESPONSES.index(response.downcase) < 2 ? play_again = true : play_again = false
end