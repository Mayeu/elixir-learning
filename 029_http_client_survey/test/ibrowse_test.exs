defmodule IbrowseTest do
  use ExUnit.Case

  test "parsing the content of a page" do
    { :ok, '200', _headers, body } = :ibrowse.send_req('http://example.com', [], :get)
    assert Regex.match?(~r/illustrative examples/, :erlang.list_to_binary(body))
  end
end
