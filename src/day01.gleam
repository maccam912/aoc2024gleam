import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

pub fn part1(input: String) -> Int {
  let #(left, right) = parse_input(input)
  let sorted_left = list.sort(left, int.compare)
  let sorted_right = list.sort(right, int.compare)
  let result =
    list.map2(sorted_left, sorted_right, fn(a, b) { int.absolute_value(a - b) })
  list.fold(result, 0, fn(acc, x) { acc + x })
}

pub fn part2(input: String) -> Int {
  let pairs = parse_input(input)
  let #(left, right) = pairs

  // For each number in left list, count occurrences in right list and multiply
  list.fold(left, 0, fn(acc, num) {
    let count = list.filter(right, fn(x) { x == num }) |> list.length
    acc + num * count
  })
}

fn parse_input(input: String) -> #(List(Int), List(Int)) {
  let lines =
    string.split(input, "\n")
    |> list.filter(fn(line) { string.length(line) > 0 })

  let pairs =
    list.map(lines, fn(line) {
      let numbers =
        string.split(line, " ")
        |> list.filter(fn(s) { string.length(s) > 0 })
        |> list.map(fn(s) {
          let trimmed = string.trim(s)
          result.unwrap(int.parse(trimmed), 0)
        })
      case numbers {
        [a, b] -> #(a, b)
        _ -> {
          io.println("Invalid line: " <> line)
          #(0, 0)
        }
      }
    })

  let left = list.map(pairs, fn(p) { p.0 })
  let right = list.map(pairs, fn(p) { p.1 })
  #(left, right)
}
