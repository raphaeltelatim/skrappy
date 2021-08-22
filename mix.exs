defmodule Skrappy.MixProject do
  use Mix.Project

  def project do
    [
      app: :skrappy,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:floki, "~> 0.31.0"},
      {:httpoison, "~> 1.8"},
      {:mox, "~> 1.0", only: :test}
    ]
  end
end
