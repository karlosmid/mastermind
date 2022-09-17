defmodule Mastermind.Utils do
  @moduledoc """
  mastermind gameplay helpers
  """

  def set_code() do
    colors = [
      "fill-red-500",
      "fill-blue-500",
      "fill-orange-500",
      "fill-green-500",
      "fill-fuchsia-500",
      "fill-yellow-500"
    ]

    ([Enum.random(colors)] ++
       [Enum.random(colors)] ++ [Enum.random(colors)] ++ [Enum.random(colors)])
    |> IO.inspect()
  end

  def set_hints(assigns) do
    pins = assigns.pins
    code = assigns.code

    pins_codes = maybe_set_0_to_pin_position_if_position_match(pins, code)

    pins_freq = Enum.frequencies(Enum.filter(pins_codes.pins, fn x -> x != 0 end))
    code_freq = Enum.frequencies(Enum.filter(pins_codes.code, fn x -> x != 0 end))

    colors =
      pins_codes.pins
      |> Enum.filter(fn pin -> pin != 0 end)
      |> Enum.uniq()
      |> Enum.reduce([], fn pin, acc ->
        cond do
          Map.get(code_freq, pin) == nil ->
            acc

          Map.get(pins_freq, pin) > Map.get(code_freq, pin) ->
            acc ++
              Enum.map(1..(Map.get(pins_freq, pin) - Map.get(code_freq, pin)), fn _x -> 1 end)

          Map.get(pins_freq, pin) <= Map.get(code_freq, pin) ->
            acc ++ Enum.map(1..Map.get(pins_freq, pin), fn _x -> 1 end)
        end
      end)

    Enum.filter(pins_codes.pins, fn pin -> pin == 0 end) ++ colors
  end

  def set_pin(index, color, pins) do
    current =
      if Enum.at(pins, index) == color do
        "empty"
      else
        color
      end

    cond do
      index == 0 -> [current] ++ Enum.slice(pins, 1..3)
      index == 1 -> [Enum.at(pins, 0)] ++ [current] ++ Enum.slice(pins, 2..3)
      index == 2 -> Enum.slice(pins, 0..1) ++ [current] ++ [Enum.at(pins, 3)]
      true -> Enum.slice(pins, 0..2) ++ [current]
    end
  end

  defp maybe_set_0_to_pin_position_if_position_match(pins, code) do
    Enum.reduce(0..3, %{pins: [], code: []}, fn index, acc ->
      if Enum.at(pins, index) ==
           Enum.at(code, index) do
        Map.put(acc, :pins, Map.get(acc, :pins) ++ [0])
        |> Map.put(:code, Map.get(acc, :code) ++ [0])
      else
        Map.put(acc, :pins, Map.get(acc, :pins) ++ [Enum.at(pins, index)])
        |> Map.put(:code, Map.get(acc, :code) ++ [Enum.at(code, index)])
      end
    end)
  end
end
