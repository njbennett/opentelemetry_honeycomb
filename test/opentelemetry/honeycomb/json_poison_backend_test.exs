defmodule OpenTelemetry.Honeycomb.Json.PoisonBackendTest do
  use ExUnit.Case, async: true

  alias OpenTelemetry.Honeycomb.Json.PoisonBackend

  test "decode!/1" do
    assert PoisonBackend.decode!("{}") == %{}
  end

  test "encode_to_iodata!/1" do
    assert PoisonBackend.encode_to_iodata!(%{}) == "{}"
  end
end
