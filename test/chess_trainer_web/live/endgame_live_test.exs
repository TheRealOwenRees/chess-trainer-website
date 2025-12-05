defmodule ChessTrainerWeb.EndgameLiveTest do
  use ChessTrainerWeb.ConnCase

  import Phoenix.LiveViewTest
  import ChessTrainer.EndgamesFixtures

  @create_attrs %{
    message: "some message",
    result: :draw,
    key: "some key",
    fen: "some fen",
    notes: "some notes"
  }
  @update_attrs %{
    message: "some updated message",
    result: :win,
    key: "some updated key",
    notes: "some updated notes"
  }
  @invalid_create_attrs %{message: nil, result: "draw", key: nil, fen: "win", notes: nil}
  @invalid_update_attrs %{message: nil, result: "draw", key: nil, notes: nil}
  defp create_endgame(_) do
    endgame = endgame_fixture()

    %{endgame: endgame}
  end

  describe "Index" do
    setup [:create_endgame]

    test "lists all endgames", %{conn: conn, endgame: endgame} do
      {:ok, _index_live, html} = live(conn, ~p"/admin/endgames")

      assert html =~ "Listing Endgames"
      assert html =~ endgame.fen
    end

    test "saves new endgame", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/endgames")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Endgame")
               |> render_click()
               |> follow_redirect(conn, ~p"/admin/endgames/new")

      assert render(form_live) =~ "New Endgame"

      assert form_live
             |> form("#endgame-form", endgame: @invalid_create_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#endgame-form", endgame: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/admin/endgames")

      html = render(index_live)
      assert html =~ "Endgame created successfully"
      assert html =~ "some fen"
    end

    test "updates endgame in listing", %{conn: conn, endgame: endgame} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/endgames")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#endgames-#{endgame.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/admin/endgames/#{endgame}/edit")

      assert render(form_live) =~ "Edit Endgame"

      assert form_live
             |> form("#endgame-form", endgame: @invalid_update_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#endgame-form", endgame: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/admin/endgames")

      html = render(index_live)
      assert html =~ "Endgame updated successfully"
    end

    test "deletes endgame in listing", %{conn: conn, endgame: endgame} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/endgames")

      assert index_live |> element("#endgames-#{endgame.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#endgames-#{endgame.id}")
    end
  end

  describe "Show" do
    setup [:create_endgame]

    test "displays endgame", %{conn: conn, endgame: endgame} do
      {:ok, _show_live, html} = live(conn, ~p"/admin/endgames/#{endgame}")

      assert html =~ "Show Endgame"
      assert html =~ endgame.fen
    end

    test "updates endgame and returns to show", %{conn: conn, endgame: endgame} do
      {:ok, show_live, _html} = live(conn, ~p"/admin/endgames/#{endgame}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/admin/endgames/#{endgame}/edit?return_to=show")

      assert render(form_live) =~ "Edit Endgame"

      assert form_live
             |> form("#endgame-form", endgame: @invalid_update_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#endgame-form", endgame: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/admin/endgames/#{endgame}")

      html = render(show_live)
      assert html =~ "Endgame updated successfully"
    end
  end
end
