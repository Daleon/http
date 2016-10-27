require 'minitest/autorun'
require 'minitest/pride'
require './lib/game.rb'

class GameTest < Minitest::Test
  def test_tracks_guesses_with_default_of_0
    game = Game.new
    assert_equal 0, game.guesses
  end

  def test_returns_mortal_kombat_message_when_beginning_new_game
    game = Game.new
    assert_equal "Choose your DESTINY!!", game.begin
  end

  def test_remembers_magic_num_when_beginning_new_game
    game = Game.new
    game.begin
    guesseable_numbers = (0..100).to_a
    assert (guesseable_numbers).include?(game.lucky_number)
  end

  def test_tells_user_number_of_current_guesses_and_complains_about_it
    game = Game.new
    assert_equal "You've 0 guesses... UUGGHH! Guess something!",
      game.current_guess_num
  end

  def test_picks_number_0_to_100
    game = Game.new
    guesseable_numbers = (0..100).to_a
    assert guesseable_numbers.include?(game.magic_num)
  end

  def test_compares_two_numbers_and_informs_user_if_correct_or_nil
    game = Game.new
    assert_equal "Yay!  You're RIGHT!!", game.compare_guess(1, "1")
    assert_equal "GUESS A NUMBER!!", game.compare_guess(nil, "5")
  end

  def test_compare_guessed_number_and_magic_number_then_informs_user_hi_or_lo
    game = Game.new
    assert_equal "Too low.", game.compare_guess(4, "1")
    assert_equal "Too high.", game.compare_guess(45, "90")
  end

  def test_if_guess_is_the_proper_format
    game = Game.new
    assert_equal "Guess a number only, please.", game.compare_guess(46, "4a")
  end
end
