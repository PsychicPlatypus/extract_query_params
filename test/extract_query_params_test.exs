defmodule ExtractQueryParamsTest do
  @moduledoc false

  use ExUnit.Case
  doctest ExtractQueryParams

  alias ExtractQueryParams

  describe "to_variables/2" do
    test "should support non binary types" do
      assert {
               "foo = ? AND bar = ? AND baz = ?",
               [1, -2, 2.15]
             } = ExtractQueryParams.to_variables(foo: 1, bar: -2, baz: 2.15)
    end

    test "should support binary types" do
      assert {
               "foo = ? AND bar = ? AND baz = ?",
               ["foo", "bar", "baz"]
             } = ExtractQueryParams.to_variables(foo: "foo", bar: "bar", baz: "baz")
    end

    test "should support OR operator" do
      assert {
               "foo = ? OR bar = ? OR baz = ?",
               ["foo", "bar", "baz"]
             } = ExtractQueryParams.to_variables([foo: "foo", bar: "bar", baz: "baz"], "OR")
    end
  end
end
