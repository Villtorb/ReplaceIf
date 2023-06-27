defmodule ReplaceIf.MixProject do
  use Mix.Project

  def project do
    [
      app: :replaceif,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "ReplaceIf",
      source_url: "https://github.com/Villtorb/ReplaceIf"
    ]
  end

  def application do
    [
    ]
  end

  defp deps do
    [
    ]
  end
end
