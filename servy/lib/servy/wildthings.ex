defmodule Servy.Wildthings do
  alias Servy.Bear

  def list_bears do
    with {:ok, content} <- File.read("./db/bears.json"),
         result <- Poison.decode!(content, as: %{"bears" => [%Bear{}]}) do
      Map.get(result, "bears")
    end
  end

  def get_bear(id) when is_integer(id) do
    Enum.find(list_bears(), fn bear -> bear.id == id end)
  end

  def get_bear(id) when is_binary(id) do
    id
    |> String.to_integer()
    |> get_bear()
  end
end
