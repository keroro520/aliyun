defmodule Aliyun.Test.Auth do
  use ExUnit.Case, async: true
  alias Aliyun.Auth

  setup_all do
    env = Application.get_env(:aliyun, Aliyun, [])
    env = Keyword.put(env, :scope, "oss-example")
    env = Keyword.put(env, :access_key_id, "44CF9590006BF252F707")
    env = Keyword.put(env, :access_key_secret, "OtxrzxIsfpFjA7SwPzILwy8Bw21TLhquhboDYROV")
    Application.put_env(:aliyun, Aliyun, env)

    :ok
  end

  test "authorization" do
    options = [method: "PUT",
               key: "nelson",
               date: "Thu, 17 Nov 2005 18:49:58 GMT",
               content_type: "text/html",
               content_md5: "ODBGOERFMDMzQTczRUY3NUE3NzA5QzdFNUYzMDQxNEM=",
               headers: [{"x-oss-magic", "abracadabra"},
                         {"x-oss-meta-author", "foo@bar.com"}]]
    assert Auth.authorization(options) == "OSS 44CF9590006BF252F707:26NBxoKdsyly4EDv6inkoDft/yA="
  end
end
