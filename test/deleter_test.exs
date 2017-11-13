defmodule Aliyun.Test.Deleter do
  use ExUnit.Case, async: false
  alias Aliyun.{Downloader,Uploader,Deleter}

  @key "foo/bar"

  setup_all do
    {:ok, _} = Application.ensure_all_started :httpoison
    :ok
  end

  test "download" do
    assert %{status_code: 200} = Uploader.upload(@key, [], "foo", [])
    assert %{status_code: 200} = Downloader.download(@key, [], [])
    assert %{status_code: 204} = Deleter.delete(@key, [], [])
    assert %{status_code: 404} = Downloader.download(@key, [], [])
  end
end
