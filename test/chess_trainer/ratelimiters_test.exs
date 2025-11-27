defmodule ChessTrainer.RatelimitersTest do
  use ExUnit.Case, async: true

  alias ChessTrainer.Ratelimiters

  describe "Lichess rate limiter" do
    setup do
      # Reset cooldown before each test to ensure a clean slate
      Ratelimiters.lichess_reset_cooldown()
      :ok
    end

    test "lichess_add_cooldown sets a cooldown" do
      assert true = Ratelimiters.lichess_add_cooldown()

      case Ratelimiters.lichess_check_cooldown() do
        {:cooldown, remaining} ->
          assert remaining > 0

        other ->
          flunk("Expected cooldown, got: #{inspect(other)}")
      end
    end

    test "lichess_reset_cooldown clears cooldown" do
      Ratelimiters.lichess_add_cooldown()
      assert true = Ratelimiters.lichess_reset_cooldown()
      assert {:ok, 0} = Ratelimiters.lichess_check_cooldown()
    end

    test "lichess_check_cooldown returns {:ok, 0} when no cooldown" do
      assert {:ok, 0} = Ratelimiters.lichess_check_cooldown()
    end

    test "lichess_check_cooldown returns {:cooldown, ms} when cooldown active" do
      Ratelimiters.lichess_add_cooldown()
      assert {:cooldown, remaining} = Ratelimiters.lichess_check_cooldown()
      assert is_integer(remaining)
      assert remaining > 0
    end
  end
end
