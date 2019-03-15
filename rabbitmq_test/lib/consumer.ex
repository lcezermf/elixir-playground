defmodule Consumer do
  def receive do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    # check if the queue exists
    AMQP.Queue.declare(channel, "hello")
    AMQP.Basic.consume(channel, "hello", nil, no_ack: true)
    IO.puts(" [*] Waiting for messages. To exit press CTRL+C, CTRL+C")
    wait_for_messages()
  end

  def wait_for_messages do
    receive do
      {:basic_deliver, payload, _meta} ->
        IO.puts("[x]  Received #{payload}")
    end

    wait_for_messages()
  end
end
