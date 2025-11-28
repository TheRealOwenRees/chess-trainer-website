defmodule ChessTrainer.CacheTest do
  use ExUnit.Case

  alias ChessTrainer.Cache

  @table :test

  describe "ChessTrainer.Cache function tests" do
    test "start_link/1" do
      assert {:ok, pid} = Cache.start_link(@table)
      assert is_pid(pid)
    end
  end
end
