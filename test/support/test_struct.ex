defmodule TestStruct do
  defstruct [:field, :nested_struct]

  defmodule NestedStruct do
    defstruct [:another_field]

    defimpl Inspect do
      def inspect(%NestedStruct{another_field: another_field}, _opts \\ []) do
        another_field <> " impl inspect"
      end
    end
  end
end
