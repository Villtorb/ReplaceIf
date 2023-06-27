# ReplaceIf

Adds two helper functions for use in Elixir:
- replace_if 
- transform_if

The intention is to make it simpler to ensure default values in a single line when `with` might seem like overkill.

```Elixir
get_process() 
|> replace_if(nil, &spawn_process/0)
|> send_msg("Hi")
```

### replace_if

Replaces the `input` if the `condition` is true. 
The `condition` can be a literal and it will test for eqaulity: `==/2`. 
The `condition` can be a `&function/1` which will apply the `input` as the argument to the `condition` 
Returns the `input` if false, or the `replacement` if true 
The `replacement` can be a `&function/0` and it will be evaluated only when the `condition` is true

```Elixir
:error|> replace_if(:error, :default) 
# :default

420 |> replace_if(&(&1 > 360), "no scope")
# "no scope"
```

### transform_if

The same as `replace_if/3` but instead of passing in a replacement, you would pass in a `&function/1` that will take the input as the argument, and return the result

```Elixir
prepend_this = &([:this | &1]
[:that] |> transform_if(&is_list/1, prepend_this)) 
# [:this, :that]
```



