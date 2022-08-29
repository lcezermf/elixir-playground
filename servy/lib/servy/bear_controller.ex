defmodule Servy.BearController do
  # alias Servy.BearView
  import Servy.View, only: [render: 3]

  alias Servy.Bear
  alias Servy.Wildthings

  def index(request) do
    bears =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.sort_asc_by_name(&1, &2))

    render(request, "index.eex", bears: bears)
  end

  def show(request, %{"id" => id}) do
    bear = Wildthings.get_bear(id)

    render(request, "show.eex", bear: bear)
  end

  def create(request, %{"name" => name, "type" => type}) do
    %{request | status: 201, resp_body: "Created a #{type} bear named #{name}!"}
  end

  def delete(request, %{"id" => _id}) do
    %{request | status: 403, resp_body: "Deleting a bear is forbidden!"}
  end
end
