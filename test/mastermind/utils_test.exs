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
  end
end
