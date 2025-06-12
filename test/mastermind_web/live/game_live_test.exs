defmodule MastermindWeb.GameLiveTest do
  use MastermindWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "game page", %{conn: conn} do
    {:ok, _view, html} = live(conn, "/")
    assert html =~ "Mastermind"
  end
end
