defmodule Quotation.Consumer do
  def handle_message(%{value: value} = message) when not is_nil(value) do
    decoded = Poison.decode!(message.value)
    quotation = %Quotation{
      currency_from: decoded["currency_from"],
      currency_to: decoded["currency_to"],
      amount: decoded["amount"],
      quotation_value: decoded["quotation_value"]
    }
    :ok
  end
end
