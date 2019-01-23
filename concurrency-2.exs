send(self, "a message")

receive do
  message -> IO.puts(message)
end

####

send(self, {:message, 1})

receive do
  {:message, id} -> IO.puts("Received message: #{id}")
end

###

send(self, {:message, 1})

receive do
  message -> IO.puts(message)
  after 5000 -> IO.puts("Message not received")
end

"Message not received"

run_query = fn(query_def) ->
  :timer.sleep(2000)
  "#{query_def} result"
end

async_query = fn(query_def) ->
  caller = self

  spawn(fn ->
    send(caller, {:query_result, run_query.(query_def)})
  end)
end

get_result = fn ->
  receive do
    {:query_result, result} -> result
  end
end

1..5 |> Enum.map(&async_query.("query #{&1}")) |> Enum.map(fn(_) ->  get_result.() end)
