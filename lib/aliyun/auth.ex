defmodule Aliyun.Auth do
  @moduledoc """
  Authorization module

  Document about signature: https://help.aliyun.com/document_detail/31951.html

  """

  def authorization(options) do
    "OSS " <> Aliyun.config[:access_key_id] <> ":" <> signature(options)
  end

  def signature(options) do
    key          = Keyword.fetch!(options, :key)
    method       = Keyword.fetch!(options, :method)
    content_type = Keyword.fetch!(options, :content_type)
    content_md5  = Keyword.get(options, :content_md5, "")
    date         = Keyword.get(options, :date, Aliyun.Utils.gmt_now)
    headers      = Keyword.get(options, :headers, [])

    canonicalized_oss_resource = canonicalized_oss_resource(key)
    canonicalized_oss_headers = canonicalize_oss_headers(headers)

    str = method                    <> "\n" <>
          content_md5               <> "\n" <>
          content_type              <> "\n" <>
          date                      <> "\n" <>
          canonicalized_oss_headers <>
          canonicalized_oss_resource

    :crypto.hmac(:sha, Aliyun.config[:access_key_secret], str)
    |> :base64.encode_to_string
    |> to_string
  end

  defp canonicalized_oss_resource(key) do
    "/" <> Aliyun.config[:scope] <> "/" <> key
  end

  defp canonicalize_oss_headers(headers) do
    headers = Enum.filter(headers, fn {"x-oss-" <> _, _} -> true; _ -> false end)
    canonicalize_oss_headers(headers, "")
  end

  defp canonicalize_oss_headers([], canonical), do: canonical
  defp canonicalize_oss_headers([{key, value}|rest], canonical) do
    canonicalize_oss_headers(rest, "#{canonical}#{key}:#{value}\n")
  end
end
