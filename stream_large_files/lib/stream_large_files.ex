defmodule HTTPStream do
  def get(url) do
    Stream.resource(
      start_fun(url),
      next_fun(),
      end_fun()
    )
  end

  def start_fun(url) do
    fn ->
      HTTPoison.get!(
        url, %{},
        [stream_to: self(), async: :once]
      )
    end
  end

  def next_fun do
    fn %HTTPoison.AsyncResponse{id: id}=resp->
      receive do
        %HTTPoison.AsyncStatus{id: ^id, code: code}->
          IO.inspect(code, label: "STATUS: ")
          HTTPoison.stream_next(resp)
          {[], resp}
        %HTTPoison.AsyncHeaders{id: ^id, headers: headers}->
          IO.inspect(headers, label: "HEADERS: ")
          HTTPoison.stream_next(resp)
          {[], resp}
        %HTTPoison.AsyncChunk{id: ^id, chunk: chunk}->
          HTTPoison.stream_next(resp)
          {[chunk], resp}
        %HTTPoison.AsyncEnd{id: ^id}->
          {:halt, resp}
      end
    end
  end

  def end_fun do
    fn resp ->
      :hackney.stop_async(resp.id)
    end
  end
end


# image_url = "https://www.spacetelescope.org/static/archives/images/original/heic0506a.tif"

# image_url
# |> HTTPStream.get()
# |> StreamGzip.gzip()
# |> Stream.into(File.stream!("image.tif.gz"))
# |> Stream.run
