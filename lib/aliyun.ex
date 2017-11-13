defmodule Aliyun do
  def config do
    Keyword.merge(default_config, Application.get_env(:aliyun, Aliyun, []))
  end

  defp default_config do
    [user_agent: "AliyunElixir/#{System.version}",
     content_type: "application/x-www-form-urlencoded"]
  end
end
