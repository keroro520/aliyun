defmodule Aliyun.Deleter do
  @moduledoc """
  Deleter module

  Document about deleting: help.aliyun.com/document_detail/31982.html
  """

  def delete(key, headers, options) do
    date         = headers[:date] || Aliyun.Utils.gmt_now
    content_type = headers[:content_type] || ""
    content_md5  = headers[:content_md5] || ""
    authorization = Aliyun.Auth.authorization([key: key,
                                               date: date,
                                               method: "DELETE",
                                               content_type: content_type,
                                               content_md5: content_md5,
                                               headers: headers])
    headers = Keyword.merge(headers, [date: date,
                                      authorization: authorization])
    up_host = options[:address] || Aliyun.config[:up_host]
    url = up_host <> "/" <> key

    Aliyun.HTTP.delete(url, headers, options)
  end
end
