defmodule Ink.Encoder do
  @moduledoc """
  Responsible for encoding any value to JSON. Uses `Jason` for the JSON
  encoding, but converts values that are not handled by `Jason` before that,
  like tuples or PIDs.
  """

  @doc """
  Accepts a map and recursively replaces all JSON incompatible values with JSON
  encodable values. Then converts the map to JSON.
  """
  def encode(map) do
    map
    |> encode_value
    |> Jason.encode()
  end

  defp encode_value(value)
       when is_pid(value) or is_port(value) or is_reference(value) or
              is_tuple(value) or is_function(value),
       do: inspect(value)

  defp encode_value(%{__struct__: struct} = value) do
    case Inspect.impl_for(value) do
      Inspect.Any ->
        value
        |> Map.from_struct()
        |> Map.put("__struct__", struct)
        |> encode_value

      _ ->
        inspect(value)
    end
  end

  defp encode_value(value) when is_map(value) do
    Enum.into(value, %{}, fn {k, v} ->
      {encode_value(k), encode_value(v)}
    end)
  end

  defp encode_value(value) when is_list(value),
    do: Enum.map(value, &encode_value/1)

  defp encode_value(value), do: value
end
