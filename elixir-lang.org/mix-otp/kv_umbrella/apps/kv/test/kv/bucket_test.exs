defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  # Calling setup/1 to do things before a test
  setup do
    {:ok, bucket} = KV.Bucket.start_link
    # This is the test context, its a dictionnary
    {:ok, bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    # `bucket` is now the bucket from the setup block
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "delete values by key", %{bucket: bucket} do
    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.delete(bucket, "milk") == 3
    assert KV.Bucket.get(bucket, "milk") == nil
  end
end
