defmodule Producer do
  def send do
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    # check if the queue exists
    AMQP.Queue.declare(channel, "hello")
    AMQP.Basic.publish(channel, "", "hello", "Hello World!")
    IO.puts("[x] Sent 'Hello World' message")
    AMQP.Connection.close(connection)
  end
end
