use Mix.Config

config :kaffe,
  consumer: [
    endpoints: [localhost: 9092],
    # the topic(s) that will be consumed
    topics: ["quotation_topic"],
    # the consumer group for tracking offsets in Kafka
    consumer_group: "quotation-consumer-group",
    # the module that will process messages
    message_handler: Quotation.Consumer
  ]
