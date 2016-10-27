require 'minitest/autorun'
require 'minitest/pride'
require './lib/parse_and_format'

class ParseAndFormatTest < Minitest::Test
  include ParseAndFormat

  def test_breaks_request_into_lines_for_debugger
    lines = ["GET / HTTP/1.1", "Host: 127.0.0.1:9292", "Connection: keep-alive",
             "Cache-Control: no-cache", "User-Agent: Mozilla/5.0",
             "Postman-Token: 602c9eaf-23a7-276a-f55b-59f1cf0ee4c2",
             "Accept: */*, Accept-Encoding: gzip, deflate, Accept-Language: en-US"]
    result = "Verb: GET\nPath: /\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\nOrigin: #{`ipconfig getifaddr en0`.chomp}\nAccept: */*, Accept-Encoding"
    assert_equal result, debugger(lines)
  end

  def test_can_find_a_word_from_dictionary_file
    assert_equal "a known", word_search("test")
    assert_equal "not a known", word_search("ahstd")
  end

  def test_can_combine_and_assign_values_to_a_hash
    assert_equal ({Verb: "GET", Path: "/", Protocol: "HTTP/1.1"}),
      assign_to_debugger(["GET / HTTP/1.1"])
  end

  def test_formats_the_hash_for_output
    assert_equal "Verb: GET\nPath: /\nProtocol: HTTP/1.1",
      format_output({Verb: "GET", Path: "/", Protocol: "HTTP/1.1"})
  end

  def test_determines_and_returns_the_verb_as_its_own_string
    assert_equal "GET", check_type_of_request(["GET / HTTP/1.1"])
  end

  def test_this_program_can_determine_path_independently
    assert_equal "/", requested_path(["GET / HTTP/1.1"])
  end

  def test_finds_the_content_length_of_a_post_request
    assert_equal 44, find_content_length(["POST / HTTP/1.1", "Content-Length: 44"])
  end
end
