defmodule ExtractQueryParams do
  @moduledoc """
  Module for extracting query parameters from a list of keywords.
  """

  @supported_logical_operators [
    "AND",
    "OR",
    "NOT"
  ]

  @doc """
  Turns list of keywords to SQL statement variables, connected with an operator (defaults to "AND").

  ## Examples

      iex> ExtractQueryParams.to_variables(foo: "bar")
      {"foo = ?", ["bar"]}

  """
  @spec to_variables(list(keyword())) :: {binary(), list(any)}
  def to_variables([]), do: {"", [""]}

  def to_variables(keywords), do: to_variables(keywords, "AND")

  @spec to_variables(list(keyword()), binary()) :: {binary(), any()}
  def to_variables([], _), do: {"", [""]}

  def to_variables(keywords, logical_operator)
      when logical_operator in @supported_logical_operators do
    keywords_to_query_map(keywords)
    |> case do
      %{query: [], variables: []} ->
        ""

      %{query: query, variables: vars} ->
        {
          query |> Enum.reverse() |> Enum.join(" #{logical_operator} "),
          vars |> Enum.reverse()
        }
    end
  end

  def to_variables(_, _) do
    {"", [""]}
  end

  @doc """
  Turns list of keywords to SQL statement variables, connected with an operator (defaults to "AND").
  Raises an ArgumentError if the logical operator is not supported.

  ## Examples

      iex(1)> ExtractQueryParams.to_variables!([foo: "foo", bar: "bar"], "AND")
      {"foo = ? AND bar = ?", ["foo", "bar"]}

      iex(2)> ExtractQueryParams.to_variables!([foo: "foo", bar: "bar"], "UNSUPPORTED")
      ** (ArgumentError) logical operator "UNSUPPORTED" is not supported.

  """
  @spec to_variables!(list(keyword()), binary()) :: {binary(), list(any())}
  def to_variables!(keywords, logical_operator)
      when logical_operator in @supported_logical_operators do
    to_variables(keywords, logical_operator)
  end

  def to_variables!(_, logical_operator) do
    raise ArgumentError,
      message: "logical operator #{inspect(logical_operator)} is not supported."
  end

  defp keywords_to_query_map(keywords),
    do:
      keywords
      |> Enum.filter(fn
        {_, nil} -> false
        _ -> true
      end)
      |> Enum.map(fn {atom, variable} ->
        {Atom.to_string(atom) <> " = ?", variable}
      end)
      |> Enum.reduce(
        %{query: [], variables: []},
        fn {query, variable}, %{query: query_, variables: variables_} ->
          %{
            query: [query | query_],
            variables: [variable | variables_]
          }
        end
      )
end
