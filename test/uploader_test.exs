defmodule Aliyun.Test.Uploader do
  use ExUnit.Case, async: false
  alias Aliyun.Uploader

  @key "foo/bar"

  setup_all do
    {:ok, _} = Application.ensure_all_started :httpoison
    :ok
  end

  test "upload" do
    assert %{status_code: 200} = Uploader.upload(@key, [], "foo", [])
  end
end
