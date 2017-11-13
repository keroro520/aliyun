defmodule Aliyun.Downloader do
  @moduledoc """
  Downloader module

  document about downloading: help.aliyun.com/document_detail/31980.html

  """

  def download(key, headers, options) do
    date         = headers[:date] || Aliyun.Utils.gmt_now
    content_type = headers[:content_type] || ""
    content_md5  = headers[:content_md5] || ""
    authorization = Aliyun.Auth.authorization([key: key,
                                               date: date,
                                               method: "GET",
                                               content_type: content_type,
                                               content_md5: content_md5,
                                               headers: headers])
    headers = Keyword.merge(headers, [date: date,
                                      authorization: authorization])
    io_host = options[:address] || Aliyun.config[:io_host]
    url = io_host <> "/" <> key

    Aliyun.HTTP.get(url, headers, options)
  end

  def head(key, headers, options) do
    date         = headers[:date] || Aliyun.Utils.gmt_now
    content_type = headers[:content_type] || ""
    content_md5  = headers[:content_md5] || ""
    authorization = Aliyun.Auth.authorization([key: key,
                                               date: date,
                                               method: "HEAD",
                                               content_type: content_type,
                                               content_md5: content_md5,
                                               headers: headers])
    headers = Keyword.merge(headers, [date: date,
                                      authorization: authorization])
    io_host = options[:address] || Aliyun.config[:io_host]
    url = io_host <> "/" <> key

    Aliyun.HTTP.head(url, headers, options)
  end
end
