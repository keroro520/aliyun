defmodule Aliyun.Uploader do
  @moduledoc """
  Uploader module

  Document about uploading: help.aliyun.com/document_detail/31978.html

  """

  def upload(key, headers, body, options) do
    date         = headers[:date] || Aliyun.Utils.gmt_now
    content_type = headers[:content_type] || "application/octet-stream"
    content_md5  = headers[:content_md5] || ""
    authorization = Aliyun.Auth.authorization([key: key,
                                               date: date,
                                               method: "PUT",
                                               content_type: content_type,
                                               content_md5: content_md5,
                                               headers: headers])
    headers = Keyword.merge(headers, [date: date,
                                      content_type: content_type,
                                      authorization: authorization])
    up_host = options[:address] || Aliyun.config[:up_host]
    url = up_host <> "/" <> key

    Aliyun.HTTP.put(url, headers, body, options)
  end
end
