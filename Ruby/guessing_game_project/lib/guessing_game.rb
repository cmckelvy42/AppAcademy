class GuessingGame
    def initialize(num1, num2)
        @num_attempts = 0
        @secret_num = rand(num1..num2)
        @game_over = false
    end
    def num_attempts
        @num_attempts
    end
    def game_over?
        return @game_over
    end
    def check_num(n)
        @num_attempts += 1
        @game_over = n == @secret_num
        p "you win" if @game_over
        p "too big" if n > @secret_num
        p "too small" if n < @secret_num
        return @game_over
    end
    def ask_user
        p "enter a number"
        check_num(gets.chomp.to_i)
    end

end
