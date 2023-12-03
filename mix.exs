defmodule ExtractQueryParams.MixProject do
  use Mix.Project

  def project do
    [
      app: :extract_query_params,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp description() do
    "Small, light-weight elixir package that turn keyword lists to SQL statements with variables attached."
  end

  def application do
    []
  end

  defp package() do
    [
      name: "extract_query_params",
      files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/PsychicPlatypus/extract_query_params"}
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
