defmodule Aliyun.Utils do
  @moduledoc false

  def gmt_now do
    Ecto.DateTime.utc
    |> Ecto.DateTime.to_erl
    |> rfc1123_date
  end

  def rfc1123_date({{year, month, day}, {hour, minute, second}}) do
    daynumber = :calendar.day_of_the_week {year, month, day}

    "~s, ~2.2.0w ~3.s ~4.4.0w ~2.2.0w:~2.2.0w:~2.2.0w GMT"
    |> :io_lib.format([week(daynumber), day, month(month), year, hour, minute, second])
    |> :lists.flatten
    |> to_string
  end

  defp week(1), do: 'Mon'
  defp week(2), do: 'Tue'
  defp week(3), do: 'Wed'
  defp week(4), do: 'Thu'
  defp week(5), do: 'Fri'
  defp week(6), do: 'Sat'
  defp week(7), do: 'Sun'

  defp month(1), do: 'Jan'
  defp month(2), do: 'Feb'
  defp month(3), do: 'Mar'
  defp month(4), do: 'Apr'
  defp month(5), do: 'May'
  defp month(6), do: 'Jun'
  defp month(7), do: 'Jul'
  defp month(8), do: 'Aug'
  defp month(9), do: 'Sep'
  defp month(10), do: 'Oct'
  defp month(11), do: 'Nov'
  defp month(12), do: 'Dec'
end

