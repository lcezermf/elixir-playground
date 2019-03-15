{application,rabbitmq_test,
             [{applications,[kernel,stdlib,elixir,amqp]},
              {description,"rabbitmq_test"},
              {modules,['Elixir.Consumer','Elixir.Producer',
                        'Elixir.RabbitmqTest']},
              {registered,[]},
              {vsn,"0.1.0"}]}.
