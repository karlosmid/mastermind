defmodule Mastermind.UtilsTest do
  use ExUnit.Case, async: true
  alias Mastermind.Utils

  describe "set_hints/1" do
    test "no hints" do
      code = ["fill-orange-500", "fill-green-500", "fill-fuchsia-500", "fill-green-500"]
      pins = ["fill-white-500", "fill-blue-500", "fill-red-500", "fill-red-500"]
      assigns = %{code: code, pins: pins}
      assert Utils.set_hints(assigns) == []
    end

    test "1 position" do
      code = ["fill-orange-500", "fill-green-500", "fill-fuchsia-500", "fill-green-500"]
      pins = ["fill-orange-500", "fill-blue-500", "fill-red-500", "fill-red-500"]
      assigns = %{code: code, pins: pins}
      assert Utils.set_hints(assigns) == [0]
    end

    test "1 color" do
      code = ["fill-orange-500", "fill-green-500", "fill-fuchsia-500", "fill-green-500"]
      pins = ["fill-red-500", "fill-blue-500", "fill-orange-500", "fill-red-500"]
      assigns = %{code: code, pins: pins}
      assert Utils.set_hints(assigns) == [1]
    end

    test "1 color 1 position" do
      code = ["fill-orange-500", "fill-green-500", "fill-fuchsia-500", "fill-green-500"]
      pins = ["fill-red-500", "fill-blue-500", "fill-orange-500", "fill-green-500"]
      assigns = %{code: code, pins: pins}
      assert Enum.sort(Utils.set_hints(assigns)) == [0, 1]
    end

    test "1 color 1 position duplicate color" do
      code = ["fill-orange-500", "fill-green-500", "fill-fuchsia-500", "fill-green-500"]
      pins = ["fill-green-500", "fill-blue-500", "fill-red-500", "fill-green-500"]
      assigns = %{code: code, pins: pins}
      assert Enum.sort(Utils.set_hints(assigns)) == [0, 1]
    end

    test "same color, pins frequency equal to code frequency" do
      code = ["fill-green-500", "fill-blue-500", "fill-fuchsia-500", "fill-green-500"]
      pins = ["fill-yellow-500", "fill-green-500", "fill-green-500", "fill-yellow-500"]
      assigns = %{code: code, pins: pins}
      assert Enum.sort(Utils.set_hints(assigns)) == [1, 1]
    end

    test "same color, pins frequency less than code frequency" do
      code = ["fill-green-500", "fill-blue-500", "fill-fuchsia-500", "fill-green-500"]
      pins = ["fill-yellow-500", "fill-red-500", "fill-green-500", "fill-yellow-500"]
      assigns = %{code: code, pins: pins}
      assert Enum.sort(Utils.set_hints(assigns)) == [1]
    end

    test "same color, pins frequency greater than code frequency" do
      code = ["fill-green-500", "fill-blue-500", "fill-fuchsia-500", "fill-white-500"]
      pins = ["fill-yellow-500", "fill-green-500", "fill-green-500", "fill-yellow-500"]
      assigns = %{code: code, pins: pins}
      assert Enum.sort(Utils.set_hints(assigns)) == [1]
    end

    test "same color, pins frequency greater than code frequency is 2" do
      code = ["fill-green-500", "fill-blue-500", "fill-fuchsia-500", "fill-white-500"]
      pins = ["fill-yellow-500", "fill-green-500", "fill-green-500", "fill-green-500"]
      assigns = %{code: code, pins: pins}
      assert Enum.sort(Utils.set_hints(assigns)) == [1]
    end
  end

  describe "set_code/0" do
    test "generate random codes" do
      assert Enum.count(Utils.set_code()) == 4
    end
  end

  describe "set_pins/3" do
    setup do
      [pins: ["fill-green-500", "fill-blue-500", "fill-fuchsia-500", "fill-white-500"]]
    end

    test "same color sets empty", %{pins: pins} do
      assert Enum.at(Utils.set_pin(0, "fill-green-500", pins), 0) == "empty"
    end
    
    test "index 1", %{pins: pins} do
      assert Enum.at(Utils.set_pin(1, "fill-green-500", pins), 1) == "fill-green-500"
    end
    
    test "index 2", %{pins: pins} do
      assert Enum.at(Utils.set_pin(2, "fill-green-500", pins), 2) == "fill-green-500"
    end
    
    test "index 3", %{pins: pins} do
      assert Enum.at(Utils.set_pin(3, "fill-green-500", pins), 3) == "fill-green-500"
    end
  end
end
