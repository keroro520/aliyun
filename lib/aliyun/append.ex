defmodule Aliyun.Append do
  @moduledoc """
  Append Appendable Object module

  Document about appending: help.aliyun.com/document_detail/31981.html

  """

  def append(key, position, headers, body, options) when is_integer(position) do
    date         = headers[:date] || Aliyun.Utils.gmt_now
    content_type = headers[:content_type] || "application/octet-stream"
    content_md5  = headers[:content_md5] || ""
    authorization = Aliyun.Auth.authorization([key: key <> "?append&position=#{position}",
                                               date: date,
                                               method: "POST",
                                               content_type: content_type,
                                               content_md5: content_md5,
                                               headers: headers])
    headers = Keyword.merge(headers, [date: date,
                                      content_type: content_type,
                                      authorization: authorization])
    up_host = options[:address] || Aliyun.config[:up_host]
    url = up_host <> "/" <> key <> "?append&position=#{position}"

    Aliyun.HTTP.post(url, headers, body, options)
  end
end
