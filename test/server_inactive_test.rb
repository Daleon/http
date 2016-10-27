require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'

class RubyServerTest < Minitest::Test

  def test_creates_tcp_server_object
    instance_of_server = Server.new
    assert_instance_of TCPServer, instance_of_server.server
    instance_of_server.server.close
  end

  def test_it_listens_on_port_9292_by_default
    instance_of_server = Server.new
    assert_equal 9292, instance_of_server.port
    instance_of_server.server.close
  end

  def test_it_can_listen_on_another_port
    instance_of_server = Server.new(9291)
    assert_equal 9291, instance_of_server.port
    instance_of_server.server.close
  end

  def test_number_of_times_hello_requests_while_active_defaults_to_negative_one
    instance_of_server = Server.new
    assert_equal -1, instance_of_server.hello_requests
    instance_of_server.server.close
  end

  def test_number_of_times_all_requests_while_active_defaults_to_zero
    instance_of_server = Server.new
    assert_equal 0, instance_of_server.all_requests
    instance_of_server.server.close
  end
end
