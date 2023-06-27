defmodule ReplaceIfTest do
  use ExUnit.Case, async: true
  import ReplaceIf

  test "replace_if literal" do
    assert :ok |> replace_if(:ok, :changed) == :changed
    assert :not_ok |> replace_if(:ok, :changed) == :not_ok
  end

  test "replace_if conditional" do
    is_ok = &(&1 == :ok)
    assert :ok |> replace_if(is_ok, :changed) == :changed
    assert :not_ok |> replace_if(is_ok, :changed) == :not_ok
  end

  test "replace_if, where replacement is a function" do
    is_one = &(&1 == 1)
    return_ten = fn -> 10 end
    assert 1 |> replace_if(is_one, return_ten) == 10
  end

  test "transform_if condition and transform input" do
    is_one = &(&1 == 1)
    add_one = &(&1 + 1)
    assert 1 |> transform_if(is_one, add_one) == 2
    assert 2 |> transform_if(is_one, add_one) == 2

    prepend_this = &([:this | &1])
    assert [:that] |> transform_if(&is_list/1, prepend_this) == [:this, :that]
  end
end
