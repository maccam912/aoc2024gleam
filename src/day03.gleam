import gleam/int
import gleam/list
import gleam/string

pub fn part1(input: String) -> Int {
  input
  |> string.split("\n")
  |> list.filter(fn(line) { line != "" })
  |> list.flat_map(find_multiplications)
  |> int.sum
}

fn find_multiplications(line: String) -> List(Int) {
  let chars = string.to_graphemes(line)
  find_mul_recursive(chars, [], [])
}

fn find_mul_recursive(
  chars: List(String),
  _current: List(String),
  results: List(Int),
) -> List(Int) {
  case chars {
    [] -> list.reverse(results)
    ["m", "u", "l", "(", d1, ..rest] -> {
      case is_digit(d1) {
        True -> {
          let #(num1, rest1) = collect_digits([d1], rest)
          case rest1 {
            [",", d2, ..rest2] ->
              case is_digit(d2) {
                True -> {
                  let #(num2, rest3) = collect_digits([d2], rest2)
                  case rest3 {
                    [")", ..rest4] -> {
                      case parse_nums(num1, num2) {
                        Ok(product) ->
                          find_mul_recursive(rest4, [], [product, ..results])
                        Error(_) -> find_mul_recursive(rest4, [], results)
                      }
                    }
                    _ -> find_mul_recursive(rest1, [], results)
                  }
                }
                False -> find_mul_recursive(rest1, [], results)
              }
            _ -> find_mul_recursive(rest1, [], results)
          }
        }
        False -> find_mul_recursive(rest, [], results)
      }
    }
    [_, ..rest] -> find_mul_recursive(rest, [], results)
  }
}

fn is_digit(c: String) -> Bool {
  string.contains("0123456789", c)
}

fn collect_digits(
  digits: List(String),
  chars: List(String),
) -> #(List(String), List(String)) {
  case chars {
    [] -> #(digits, [])
    [d, ..rest] ->
      case is_digit(d) && list.length(digits) < 3 {
        True -> collect_digits([d, ..digits], rest)
        False -> #(digits, chars)
      }
  }
}

fn parse_nums(digits1: List(String), digits2: List(String)) -> Result(Int, Nil) {
  let num1 = string.concat(list.reverse(digits1))
  let num2 = string.concat(list.reverse(digits2))
  case int.parse(num1), int.parse(num2) {
    Ok(n1), Ok(n2) if n1 > 0 && n1 < 1000 && n2 > 0 && n2 < 1000 -> Ok(n1 * n2)
    _, _ -> Error(Nil)
  }
}

pub fn part2(_input: String) -> Int {
  0
}
