defmodule PongTest do
  use ExUnit.Case

  test "it responds to a ping with a pong" do
    pong = spawn_link(Pong, :start, [])
    send pong, {:ping, self}
    assert_receive {:pong, pong}
  end

  test "it responds to two pings with two pongs" do
    pong = spawn_link(Pong, :start, [])
    send pong, {:ping, self}
    assert_receive {:pong, pong}
    send pong, {:ping, self}
    assert_receive {:pong, pong}
  end
end
