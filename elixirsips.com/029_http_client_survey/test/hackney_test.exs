defmodule HackneyTest do
  use ExUnit.Case

  test "parsing the content of a page" do
    {:ok, 200, _headers, client} = :hackney.get("http://example.com")
    {:ok, body} = :hackney.body(client)
    assert Regex.match?(~r/illustrative examples/, body)
  end
end
