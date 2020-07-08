defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link([])
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert is_nil(KV.Bucket.get(bucket, "milk"))

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "deletes values by key", %{bucket: bucket} do
    KV.Bucket.put(bucket, "milk", 3)
    KV.Bucket.put(bucket, "food", 5)

    assert KV.Bucket.delete(bucket, "food") == 5
    assert is_nil(KV.Bucket.get(bucket, "food"))
  end
end
