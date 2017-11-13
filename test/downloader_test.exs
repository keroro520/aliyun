defmodule Aliyun.Test.Uploader do
  use ExUnit.Case, async: false
  alias Aliyun.{Downloader, Uploader}

  @key "foo/bar"

  setup_all do
    {:ok, _} = Application.ensure_all_started :httpoison
    :ok
  end

  test "download" do
    assert %{status_code: 200} = Uploader.upload(@key, [], "foo", [])
    assert %{status_code: 200} = Downloader.download(@key, [], [])
  end

  test "head" do
    assert %{status_code: 200} = Uploader.upload(@key, [], "foo", [])
    assert %{status_code: 200} = Downloader.head(@key, [], [])
  end
end
