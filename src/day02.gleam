import gleam/string
import gleam/list
import gleam/int
import gleam/result

pub fn parse_input(input: String) -> List(List(Int)) {
  input
  |> string.trim
  |> string.split("\n")
  |> list.map(fn(line) {
    line
    |> string.split(" ")
    |> list.map(fn(n) {
      result.unwrap(int.parse(n), 0)
    })
  })
}

fn is_valid_difference(a: Int, b: Int) -> Bool {
  let diff = int.absolute_value(a - b)
  diff >= 1 && diff <= 3
}

fn is_monotonic(numbers: List(Int)) -> Bool {
  case numbers {
    [] | [_] -> True
    [_first, ..] -> {
      let all_increasing = list.fold(
        list.window_by_2(numbers),
        True,
        fn(acc, pair) { acc && pair.0 < pair.1 },
      )
      let all_decreasing = list.fold(
        list.window_by_2(numbers),
        True,
        fn(acc, pair) { acc && pair.0 > pair.1 },
      )
      all_increasing || all_decreasing
    }
  }
}

fn is_valid_differences(numbers: List(Int)) -> Bool {
  case numbers {
    [] | [_] -> True
    [_first, ..] -> {
      list.fold(
        list.window_by_2(numbers),
        True,
        fn(acc, pair) { acc && is_valid_difference(pair.0, pair.1) },
      )
    }
  }
}

pub fn is_safe(numbers: List(Int)) -> Bool {
  is_monotonic(numbers) && is_valid_differences(numbers)
}

pub fn part1(input: List(List(Int))) -> Int {
  input
  |> list.filter(is_safe)
  |> list.length
}

pub fn part2(input: List(List(Int))) -> Int {
  input
  |> list.filter(fn(numbers) {
    case is_safe(numbers) {
      True -> True
      False -> {
        // Try removing each number one at a time and check if any resulting sequence is safe
        case numbers {
          [] | [_] -> False
          _ -> {
            list.range(0, list.length(numbers) - 1)
            |> list.any(fn(i) {
              let #(before, after) = list.split(numbers, i)
              case after {
                [] -> False
                [_, ..rest] -> {
                  list.append(before, rest)
                  |> is_safe
                }
              }
            })
          }
        }
      }
    }
  })
  |> list.length
}
