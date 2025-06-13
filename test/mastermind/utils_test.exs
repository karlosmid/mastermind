defmodule Mastermind.UtilsTest do
  use ExUnit.Case, async: true
  alias Mastermind.Utils

  describe "set_hints/1" do
    test "no hints" do
      code = [:orange, :green, :fuchsia, :green]
      pins = [:empty, :blue, :red, :red]
      assigns = %{code: code, pins: pins}
      assert Utils.set_hints(assigns) == []
    end

    test "1 position" do
      code = [:orange, :green, :fuchsia, :green]
      pins = [:orange, :blue, :red, :red]
      assigns = %{code: code, pins: pins}
      assert Utils.set_hints(assigns) == [0]
    end

    test "1 color" do
      code = [:orange, :green, :fuchsia, :green]
      pins = [:red, :blue, :orange, :red]
      assigns = %{code: code, pins: pins}
      assert Utils.set_hints(assigns) == [1]
    end

    test "1 color 1 position" do
      code = [:orange, :green, :fuchsia, :green]
      pins = [:red, :blue, :orange, :green]
      assigns = %{code: code, pins: pins}
      assert Enum.sort(Utils.set_hints(assigns)) == [0, 1]
    end

    test "1 color 1 position duplicate color" do
      code = [:orange, :green, :fuchsia, :green]
      pins = [:green, :blue, :red, :green]
      assigns = %{code: code, pins: pins}
      assert Enum.sort(Utils.set_hints(assigns)) == [0, 1]
    end

    test "same color, pins frequency equal to code frequency" do
      code = [:green, :blue, :fuchsia, :green]
      pins = [:yellow, :green, :green, :yellow]
      assigns = %{code: code, pins: pins}
      assert Enum.sort(Utils.set_hints(assigns)) == [1, 1]
    end

    test "same color, pins frequency less than code frequency" do
      code = [:green, :blue, :fuchsia, :green]
      pins = [:yellow, :red, :green, :yellow]
      assigns = %{code: code, pins: pins}
      assert Enum.sort(Utils.set_hints(assigns)) == [1]
    end

    test "same color, pins frequency greater than code frequency" do
      code = [:green, :blue, :fuchsia, :red]
      pins = [:yellow, :green, :green, :yellow]
      assigns = %{code: code, pins: pins}
      assert Enum.sort(Utils.set_hints(assigns)) == [1]
    end

    test "same color, pins frequency greater than code frequency is 2" do
      code = [:green, :blue, :fuchsia, :red]
      pins = [:yellow, :green, :green, :green]
      assigns = %{code: code, pins: pins}
      assert Enum.sort(Utils.set_hints(assigns)) == [1]
    end

    test "yellow, yellow, orange, yellow" do
      code = [:yellow, :yellow, :orange, :yellow]
      pins = [:yellow, :yellow, :orange, :yellow]
      assigns = %{code: code, pins: pins}
      assert Enum.sort(Utils.set_hints(assigns)) == [0, 0, 0, 0]
    end
  end

  describe "set_code/0" do
    test "generate random codes" do
      assert Enum.count(Utils.set_code()) == 4
    end
  end

  describe "set_pins/3" do
    setup do
      [pins: [:green, :blue, :fuchsia, :red]]
    end

    test "same color sets empty", %{pins: pins} do
      assert Enum.at(Utils.set_pin(0, :green, pins), 0) == :empty
    end

    test "index 1", %{pins: pins} do
      assert Enum.at(Utils.set_pin(1, :green, pins), 1) == :green
    end

    test "index 2", %{pins: pins} do
      assert Enum.at(Utils.set_pin(2, :green, pins), 2) == :green
    end

    test "index 3", %{pins: pins} do
      assert Enum.at(Utils.set_pin(3, :green, pins), 3) == :green
    end
  end
end
