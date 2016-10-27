require 'minitest/autorun'
require 'minitest/pride'
require 'faraday'
require './lib/response'

class ResponseTest < Minitest::Test
  include Response

  def test_unknown_HTTP_path_yields_404_code
    response = Faraday.get 'http://127.0.0.1:9292/bullshitpath'
    assert_equal '404 Not Found', response.body[25...38]
    response = Faraday.get 'http://127.0.0.1:9292/anotherbullshitpath'
    assert_equal '404 Not Found', response.body[25...38]
  end

  def test_post_requests_not_on_post_path_or_on_get_path_yields_a_401_code
    response = Faraday.post 'http://127.0.0.1:9292/hello'
    assert_equal '401 Unauthorized', response.body[25...41]
    response = Faraday.post 'http://127.0.0.1:9292/datetime'
    assert_equal '401 Unauthorized', response.body[25...41]
  end

  def test_responds_with_404_code_if_path_is_incorrect
    response = Faraday.post 'http://127.0.0.1:9292/hello/'
    assert_equal '404 Not Found', response.body[25...38]
    response = Faraday.post 'http://127.0.0.1:9292/datetime_'
    assert_equal '404 Not Found', response.body[25...38]
  end

  def test_if_word_search_path_is_only_for_a_get_req_otherwise_401_code
    response = Faraday.post 'http://127.0.0.1:9292/word_search'
    assert_equal '401 Unauthorized', response.body[25...41]
    response = Faraday.get 'http://127.0.0.1:9292/word_search?word=apple'
    assert_equal 'APPLE is a known word', response.body[25...46]
  end

  def test_requests_with_intentionally_inserted_error_url_yields_500_code
    response = Faraday.get 'http://127.0.0.1:9292/force_error'
    assert_equal '500 Internal Server Error', response.body[25...50]
    response = Faraday.post 'http://127.0.0.1:9292/force_error'
    assert_equal '500 Internal Server Error', response.body[25...50]
  end

  def test_keeps_http_status_codes_in_a_hash
    assert_equal '401 Unauthorized', select_http_status_codes['401']
  end
end
