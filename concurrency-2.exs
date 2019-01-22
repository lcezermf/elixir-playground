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

Message not received


