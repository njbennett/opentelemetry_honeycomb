if Code.ensure_loaded?(Poison) do
  defmodule OpenTelemetry.Honeycomb.Json.PoisonBackend do
    @moduledoc false

    @behaviour OpenTelemetry.Honeycomb.Json

    @list_opts_versions Version.parse_requirement!(">= 4.0.0")

    @impl true
    def decode!(data), do: Poison.decode!(data)

    @impl true
    def encode_to_iodata!(data) do
      Poison.Encoder.encode(data, empty_opts())
    end

    @dialyzer {:nowarn_function, empty_opts: 0}

    # Poison 4 switched its encode options from a map to a list.
    defp empty_opts do
      with {:ok, vsn} <- :application.get_key(:poison, :vsn),
           {:ok, version} <- Version.parse(to_string(vsn)) do
        case Version.match?(version, @list_opts_versions) do
          true -> %{}
          false -> []
        end
      else
        _ -> []
      end
    end
  end
end
