require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'
require './lib/server'

class RubyServerTest < Minitest::Test

  def test_it_responds_to_an_HTTP_request
    response = Faraday.get 'http://127.0.0.1:9292'
    assert_equal String, response.body.class
  end

  def test_if_root_hello_is_requested_HTTP_responds_with_hello
    response = Faraday.get 'http://127.0.0.1:9292/hello'
    assert_equal 'Hello, World!', response.body[25...38]
  end

  def test_if_root_is_requested_HTTP_responds
    response = Faraday.get 'http://127.0.0.1:9292'
    refute_equal 'Hello, World!', response.body[25...38]
  end

  def test_it_can_take_a_word_parameter_and_search_the_dictionary
    response = Faraday.get 'http://127.0.0.1:9292/word_search?word=tree'
    assert_equal 'TREE is a known word', response.body[25...45]
    response = Faraday.get 'http://127.0.0.1:9292/word_search?word=appl'
    assert_equal 'APPL is not a known word', response.body[25...49]
  end
end
