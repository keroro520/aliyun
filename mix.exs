defmodule Aliyun.Mixfile do
  use Mix.Project

  def project do
    [app: :aliyun,
     version: "0.0.3",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [
     {:httpoison, "~> 0.11.2"},
     {:ecto, "~> 1.1.3"}
    ]
  end
end
