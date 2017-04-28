defmodule FizzBuzz do
  def fizzbuzz(number) do
    do_fizzbuzz(rem(number, 3), rem(number, 5), number)
  end

  defp do_fizzbuzz(0, 0, _number), do: "FizzBuzz"
  defp do_fizzbuzz(0, _rem5, _number), do: "Fizz"
  defp do_fizzbuzz(_rem3, 0, _number), do: "Buzz"
  defp do_fizzbuzz(_rem3, _rem5, number), do: number
end

ExUnit.start

defmodule FizzBuzzTest do
  use ExUnit.Case, async: true

  test "fizzbuzz" do
    assert FizzBuzz.fizzbuzz(1) == 1
    assert FizzBuzz.fizzbuzz(2) == 2
    assert FizzBuzz.fizzbuzz(3) == "Fizz"
    assert FizzBuzz.fizzbuzz(5) == "Buzz"
    assert FizzBuzz.fizzbuzz(15) == "FizzBuzz"
  end
end
