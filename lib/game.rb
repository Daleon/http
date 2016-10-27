class Game
  attr_accessor :guesses,
                :guess
  attr_reader   :lucky_number

  def initialize
    @guesses = 0
    @lucky_number
    @guess
  end

  def begin
    @lucky_number = magic_num
    "Choose your DESTINY!!"
  end

  def current_guess_num
    "You've #{guesses} guesses... UUGGHH! Guess something!"
  end

  def magic_num
    rand(0..100)
  end

  def compare_guess(magic_number, guess)
    return "Guess a number only, please." if !format_check(guess)
    return "GUESS A NUMBER!!"             if magic_number.nil? || guess.nil?
    guess = guess.to_i
    return "Yay!  You're RIGHT!!"         if magic_number == guess
    if magic_number > guess
      "Too low."
    else magic_number < guess
      "Too high."
    end
  end

  def format_check(guess)
    guess.chars.all? do |char|
      char.between?("0", "9")
    end
  end
end
