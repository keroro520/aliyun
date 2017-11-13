defmodule Aliyun.Test.Append do
  use ExUnit.Case, async: false
  alias Aliyun.Append
  alias Aliyun.Deleter
  alias Aliyun.Downloader

  @key "foo/bar"

  setup_all do
    {:ok, _} = Application.ensure_all_started :httpoison
    :ok
  end

  test "upload" do
    Deleter.delete(@key, [], [])
    assert %{status_code: 200, headers: headers} = Append.append(@key, 0, [], "foo", [])
    assert {"x-oss-next-append-position", "#{3}"} in headers
    assert %{status_code: 200, body: "foo"} = Downloader.download(@key, [], [])
    assert %{status_code: 200, headers: headers} = Append.append(@key, 3, [], "foo", [])
    assert {"x-oss-next-append-position", "#{6}"} in headers
    assert %{status_code: 200, body: "foofoo"} = Downloader.download(@key, [], [])


    assert %{status_code: 409, headers: headers} = Append.append(@key, 3, [], "foo", [])
    assert {"x-oss-next-append-position", "#{6}"} in headers
    assert %{status_code: 200, body: "foofoo"} = Downloader.download(@key, [], [])
    Deleter.delete(@key, [], [])
  end
end
