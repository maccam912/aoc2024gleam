import gleam/dict
import gleam/int
import gleam/list
import gleam/string

pub fn part1(input: String) -> Int {
  parse_input(input)
  |> list.filter(is_safe)
  |> list.length
}

pub fn part2(input: String) -> Int {
  parse_input(input)
  |> list.filter(is_safe_with_dampener)
  |> list.length
}

fn parse_input(input: String) -> List(List(Int)) {
  string.split(input, "\n")
  |> list.filter(fn(line) { string.length(line) > 0 })
  |> list.map(fn(line) {
    string.split(line, " ")
    |> list.map(string.trim)
    |> list.filter_map(int.parse)
  })
}

fn is_monotonic_increasing(pairs: List(#(Int, Int))) -> Bool {
  list.all(pairs, fn(pair) { pair.1 > pair.0 })
}

fn is_monotonic_decreasing(pairs: List(#(Int, Int))) -> Bool {
  list.all(pairs, fn(pair) { pair.1 < pair.0 })
}

fn is_monotonic(pairs: List(#(Int, Int))) -> Bool {
  is_monotonic_increasing(pairs) || is_monotonic_decreasing(pairs)
}

fn has_valid_differences(pairs: List(#(Int, Int))) -> Bool {
  list.all(pairs, fn(pair) { int.absolute_value(pair.1 - pair.0) <= 3 })
}

fn has_max_difference_3(pairs: List(#(Int, Int))) -> Bool {
  list.any(pairs, fn(pair) { int.absolute_value(pair.1 - pair.0) == 3 })
  && list.all(pairs, fn(pair) { int.absolute_value(pair.1 - pair.0) <= 3 })
}

fn is_safe(levels: List(Int)) -> Bool {
  case list.length(levels) {
    0 | 1 -> False
    _ -> {
      let pairs = list.window_by_2(levels)
      let is_mono = is_monotonic(pairs)
      let has_valid = has_valid_differences(pairs)
      let has_max_3 = has_max_difference_3(pairs)
      case is_mono && has_valid && has_max_3 {
        True -> True
        False -> is_mono && has_valid
      }
    }
  }
}

fn is_safe_with_dampener(levels: List(Int)) -> Bool {
  case is_safe(levels) {
    True -> True
    False -> {
      // Try removing each level one at a time and check if any resulting sequence is safe
      list.range(0, list.length(levels) - 1)
      |> list.any(fn(i) {
        // Take all elements before i and all elements after i
        let without_i =
          list.take(levels, i)
          |> list.append(list.drop(levels, i + 1))
        is_safe(without_i)
      })
    }
  }
}

type SequenceStats {
  SequenceStats(
    sequence: List(Int),
    min_diff: Int,
    max_diff: Int,
    is_increasing: Bool,
    length: Int,
  )
}

fn get_min_max_diff(pairs: List(#(Int, Int))) -> #(Int, Int) {
  pairs
  |> list.map(fn(pair) { int.absolute_value(pair.1 - pair.0) })
  |> list.fold(from: #(999_999, 0), with: fn(acc, diff) {
    #(int.min(acc.0, diff), int.max(acc.1, diff))
  })
}

fn group_key(stats: SequenceStats) -> String {
  string.join(
    [
      case stats.is_increasing {
        True -> "increasing"
        False -> "decreasing"
      },
      "_min",
      int.to_string(stats.min_diff),
      "_max",
      int.to_string(stats.max_diff),
      "_len",
      int.to_string(stats.length),
    ],
    "",
  )
}
