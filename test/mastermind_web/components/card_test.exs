defmodule MastermindWeb.Components.CardTest do
  use MastermindWeb.ConnCase, async: true
  use Surface.LiveViewTest

  catalogue_test(MastermindWeb.Card)
end
