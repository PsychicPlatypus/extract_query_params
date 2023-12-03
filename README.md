# ExtractQueryParams

Converts keyword list to query string with values extracted from the keyword list.

## Motivation

I was building a toy rest-api using plug-cowboy and wanted a way to turn query parameters such as `name: "Bob, age: 15` into sql statements such as:

```ex
Depo.read("SELECT * FROM customers WHERE" <> "name = ? AND age = ?", "Bob", 15)
```

in a simple way

## Usage

```ex
ExtractQueryParams.to_variables(name: "Bob", age: 15)
{"name= ? AND age = ?", ["Bob", 15]} #returns
```

The default logical operator is AND but you can also specify which operator you want:

```ex
ExtractQueryParams.to_variables([name: "Bob", age: 15], "OR")
{"name= ? OR age = ?", ["Bob", 15]} #returns
```

## Installation

Add `extract_query_params` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:extract_query_params, "~> 0.1.0"}
  ]
end
```

Documentation can be found at [https://hexdocs.pm/extract_query_params](https://hexdocs.pm/extract_query_params).
