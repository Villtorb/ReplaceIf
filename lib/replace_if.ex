defmodule ReplaceIf do
  @spec replace_if(any(), any() | fun(1), any() | fun()) :: any()
  @spec transform_if(any(), any() | fun(1), fun(1)) :: any()

  @doc """
    Replaces the `input` if the `condition` is true. \n
    The `condition` can be a literal and it will test for eqaulity: `==/2`. \n
    The `condition` can be a `&function/1` which will apply the `input` as the argument to said `condition` \n
    Returns the `input` if false, or the `replacement` if true \n
    The `replacement` can be a `&function/0` and it will be evaluated only when the `condition` is true

  ## Examples
    `iex> :error |> replace_if(:error, :default)` \n
    :default

    iex> 420 |> replace_if(&(&1 > 360), "no scope")
    "no scope"

    iex> get_process() |> replace_if(nil, &spawn_process/0) \n
    process
  """
  def replace_if(input, condition, replacement) do
    if eval_or_equal(condition, input), do: evaluate(replacement), else: input
  end

  @doc """
    The same as `replace_if/3` but instead of passing in a replacement, you would pass in a `&function/1` that will take the input as the argument, and return the result

  ## Examples
    iex> [:that] |> transform_if(&is_list/1, &([:this | &1])) \n
    [:this, :that]
  """
  def transform_if(input, condition, transformation) when is_function(transformation, 1) do
    if eval_or_equal(condition, input), do: transformation.(input), else: input
  end

  defp eval_or_equal(fun, params) when is_function(fun, 1), do: apply(fun, [params])
  defp eval_or_equal(val, other), do: val == other

  defp evaluate(fun) when is_function(fun), do: fun.()
  defp evaluate(val), do: val
end
