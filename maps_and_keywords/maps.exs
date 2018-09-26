defmodule MyMaps do
  def create_map do
    %{primary: "red", secondary: "blue"}
  end

  def get_by_key(map, key) do
    map[key]
  end
end

# colors = MyMaps.create_map
# first = colors.primary / colors[:primary]
# %{seconday: my_secondary_color} = colors

# When we use Pattern matching to extract data from a map, the "key" needs to be a key
# that exists inside the map that we will match against, in this case `secondary`

# Then the key will point to variable that will be filled with the key value, matching against a map
