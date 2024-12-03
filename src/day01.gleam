import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub type Input {
  Input(left: List(Int), right: List(Int))
}

pub fn parse_input(input: String) -> Input {
  let lines =
    input
    |> string.trim
    |> string.split("\n")
    |> list.map(fn(line) {
      let parts =
        string.split(string.trim(line), " ")
        |> list.filter(fn(s) { string.length(s) > 0 })
      let assert [left, right] = parts
      #(
        result.unwrap(int.parse(string.trim(left)), 0),
        result.unwrap(int.parse(string.trim(right)), 0),
      )
    })

  Input(
    left: list.map(lines, fn(pair) { pair.0 }),
    right: list.map(lines, fn(pair) { pair.1 }),
  )
}

pub fn part1(input: Input) -> Int {
  let sorted_left = list.sort(input.left, int.compare)
  let sorted_right = list.sort(input.right, int.compare)

  list.zip(sorted_left, sorted_right)
  |> list.map(fn(pair) { int.absolute_value(pair.0 - pair.1) })
  |> int.sum
}

pub fn part2(input: Input) -> Int {
  let count_in_right = fn(n) {
    list.filter(input.right, fn(x) { x == n })
    |> list.length
  }

  list.map(input.left, fn(n) { n * count_in_right(n) })
  |> int.sum
}
