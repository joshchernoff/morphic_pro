defmodule DateUtils do
  def formated_datetime(%DateTime{} = datetime) do
    format_with_ordinal(datetime)
  end

  def time_ago(%DateTime{} = datetime) do
    Timex.from_now(datetime)
  end

  defp format_with_ordinal(%DateTime{} = datetime) do
    month = Timex.format!(datetime, "{Mshort}")
    year = Timex.format!(datetime, "{YYYY}")
    day = datetime.day

    ordinal_day = ordinal(day)
    "#{month} #{ordinal_day} #{year}"
  end

  defp ordinal(day) when day in [11, 12, 13], do: "#{day}th"

  defp ordinal(day) do
    case rem(day, 10) do
      1 -> "#{day}st"
      2 -> "#{day}nd"
      3 -> "#{day}rd"
      _ -> "#{day}th"
    end
  end
end
