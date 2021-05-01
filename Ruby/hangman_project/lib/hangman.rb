class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample()
  end

  def initialize
    @secret_word = Hangman.random_word.downcase
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    return @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    ret = []
    @secret_word.each_char.with_index {|c, i| ret << i if c == char}
    return ret
  end

  def fill_indices(char, indices)
    indices.each{|i| @guess_word[i] = char}
  end

  def try_guess(char)
    if !already_attempted?(char)
      @attempted_chars << char
      indices = get_matching_indices(char)
      if get_matching_indices(char).size == 0
        @remaining_incorrect_guesses -= 1
        return true
      end
      fill_indices(char, indices)
      return true
    end
    p "that has already been attempted"
    return false
  end

  def ask_user_for_guess
    p "Enter a char:"
    try_guess(gets.chomp[0].downcase)
  end

  def win?
    if @guess_word.join('') == @secret_word
      p "WIN"
      return true
    end
    return false
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      p "LOSE"
      return true
    end
    return false
  end

  def game_over?
    if win? || lose?
      p @secret_word
      return true
    end
    return false
  end
end
