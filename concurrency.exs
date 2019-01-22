run_query = fn(query) ->
  :timer.sleep(2000)
  "#{query} result"
end


async_query = fn(query_def) ->
  spawn(fn -> IO.puts(run_query.(query_def)) end)
end

Enum.each(1..5, &async_query.("query #{&1}"))
