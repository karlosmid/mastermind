defmodule Mastermind.Utils do
  @moduledoc """
  mastermind gameplay helpers
  """

  def colors, do: [:red, :blue, :orange, :green, :fuchsia, :yellow]

  def set_code() do
    colors()
    |> Enum.shuffle()
    |> Enum.take_random(4)
  end

  def set_hints(assigns) do
    pins = assigns.pins
    code = assigns.code

    pins_codes = maybe_set_0_to_pins_and_code_position_if_position_match(pins, code)

    pins_color_freq_without_position_match =
      Enum.frequencies(Enum.filter(pins_codes.pins, fn x -> x != 0 end))

    code_color_freq_without_position_match =
      Enum.frequencies(Enum.filter(pins_codes.code, fn x -> x != 0 end))

    colors =
      maybe_set_1_for_color_match_including_duplicate_colors(
        pins_codes.pins,
        pins_color_freq_without_position_match,
        code_color_freq_without_position_match
      )

    (Enum.filter(pins_codes.pins, fn pin -> pin == 0 end) ++ colors)
    |> Enum.shuffle()
  end

  def set_pin(index, color, pins) do
    current =
      if Enum.at(pins, index) == color,
        do: :empty,
        else: color

    cond do
      index == 0 -> [current] ++ Enum.slice(pins, 1..3)
      index == 1 -> [Enum.at(pins, 0)] ++ [current] ++ Enum.slice(pins, 2..3)
      index == 2 -> Enum.slice(pins, 0..1) ++ [current] ++ [Enum.at(pins, 3)]
      true -> Enum.slice(pins, 0..2) ++ [current]
    end
  end

  defp maybe_set_0_to_pins_and_code_position_if_position_match(pins, code) do
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

  def maybe_set_1_for_color_match_including_duplicate_colors(
        pins,
        pins_color_freq_without_position_match,
        code_color_freq_without_position_match
      ) do
    pins
    |> Enum.filter(fn pin -> pin != 0 end)
    |> Enum.uniq()
    |> Enum.reduce([], fn pin, acc ->
      cond do
        Map.get(code_color_freq_without_position_match, pin) == nil ->
          acc

        Map.get(pins_color_freq_without_position_match, pin) >
            Map.get(code_color_freq_without_position_match, pin) ->
          acc ++
            Enum.map(
              1..Map.get(code_color_freq_without_position_match, pin),
              fn _x -> 1 end
            )

        Map.get(pins_color_freq_without_position_match, pin) <=
            Map.get(code_color_freq_without_position_match, pin) ->
          acc ++ Enum.map(1..Map.get(pins_color_freq_without_position_match, pin), fn _x -> 1 end)
      end
    end)
  end
end
