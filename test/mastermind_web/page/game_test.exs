defmodule MastermindWeb.GameTest do
  use MastermindWeb.ConnCase, async: true
  use Surface.LiveViewTest

  test "game page", %{conn: conn} do
    {:ok, _view, html} = live(conn, "/")
    assert html =~ "Mastermind"
  end
end
