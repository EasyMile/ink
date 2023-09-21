defmodule Ink.Mixfile do
  use Mix.Project

  @source_url "https://github.com/ivx/ink"
  @version "1.2.1"

  def project do
    [
      app: :ink,
      name: "Ink",
      version: @version,
      elixir: "~> 1.8",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      aliases: aliases(),
      elixirc_paths: elixirc_paths(Mix.env()),
      docs: docs()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp description do
    """
    """
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      name: :ink,
      description:
        "A backend for the Elixir Logger that logs JSON and can filter sensitive data.",
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Mario Mainz"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp deps do
    [
      {:jason, "~> 1.1"},
      {:inch_ex, "~> 2.0", only: :docs},
      {:credo, "~> 1.0", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      extras: [
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "v#{@version}",
      homepage_url: @source_url,
      formatters: ["html"]
    ]
  end

  defp aliases do
    [version: &version/1]
  end

  defp version(_) do
    IO.puts(project()[:version])
  end
end
