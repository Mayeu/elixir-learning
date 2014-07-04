defmodule KV.RouterTest do
  use ExUnit.Case, async: true

  @tag :distributed
  test "route requests accross nodes" do
    assert KV.Router.route("hello", Kernel, :node, []) ==
           :"foo@azathoth"
    assert KV.Router.route("world", Kernel, :node, []) ==
           :"bar@azathoth"
  end

  test "raises on unknow entries" do
    assert_raise RuntimeError, ~r/could not find entry/, fn ->
      KV.Router.route(<<0>>, Kernel, :node, [])
    end
  end
end
