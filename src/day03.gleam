import gleam/int
import gleam/list
import gleam/option
import gleam/regex
import gleam/string

pub fn part1(input: String) -> Int {
  let assert Ok(mul_pattern) =
    regex.from_string("mul\\((\\d{1,3}),(\\d{1,3})\\)")

  regex.scan(mul_pattern, input)
  |> list.map(fn(match) {
    let assert [num1, num2] = match.submatches
    let assert Ok(n1) = int.parse(option.unwrap(num1, "0"))
    let assert Ok(n2) = int.parse(option.unwrap(num2, "0"))
    n1 * n2
  })
  |> list.fold(0, fn(acc, x) { acc + x })
}

type Instruction {
  Multiply(num1: Int, num2: Int, index: Int)
  Do(index: Int)
  Dont(index: Int)
}

fn get_match_index(input: String, match: regex.Match) -> Int {
  let parts = string.split(input, match.content)
  case list.first(parts) {
    Ok(first) -> string.length(first)
    Error(_) -> 0
  }
}

fn parse_instruction(input: String, match: regex.Match) -> Instruction {
  let index = get_match_index(input, match)
  case match.content {
    "do()" -> Do(index: index)
    "don't()" -> Dont(index: index)
    _ -> {
      let assert [num1, num2] = match.submatches
      let assert Ok(n1) = int.parse(option.unwrap(num1, "0"))
      let assert Ok(n2) = int.parse(option.unwrap(num2, "0"))
      Multiply(num1: n1, num2: n2, index: index)
    }
  }
}

fn is_enabled(multiply: Instruction, controls: List(Instruction)) -> Bool {
  case multiply {
    Multiply(_, _, pos) -> {
      let last_control =
        controls
        |> list.filter(fn(ctrl) {
          case ctrl {
            Do(ctrl_pos) | Dont(ctrl_pos) -> ctrl_pos < pos
            _ -> False
          }
        })
        |> list.sort(fn(a, b) {
          case a, b {
            Do(pos1), Do(pos2) | Dont(pos1), Dont(pos2) -> int.compare(pos1, pos2)
            Do(pos1), Dont(pos2) | Dont(pos1), Do(pos2) -> int.compare(pos1, pos2)
            _, _ -> int.compare(0, 0)
          }
        })
        |> list.last()

      case last_control {
        Ok(Do(_)) -> True
        Ok(Dont(_)) -> False
        Error(Nil) -> True
        _ -> True
      }
    }
    _ -> False
  }
}

pub fn part2(input: String) -> Int {
  let assert Ok(mul_pattern) =
    regex.from_string("mul\\((\\d{1,3}),(\\d{1,3})\\)|do\\(\\)|don't\\(\\)")

  let instructions =
    regex.scan(mul_pattern, input)
    |> list.map(fn(match) { parse_instruction(input, match) })

  let multiplications =
    instructions
    |> list.filter(fn(instr) {
      case instr {
        Multiply(_, _, _) -> True
        _ -> False
      }
    })

  let controls =
    instructions
    |> list.filter(fn(instr) {
      case instr {
        Do(_) | Dont(_) -> True
        _ -> False
      }
    })

  multiplications
  |> list.filter(fn(mul) { is_enabled(mul, controls) })
  |> list.map(fn(mul) {
    case mul {
      Multiply(n1, n2, _) -> n1 * n2
      _ -> 0
    }
  })
  |> list.fold(0, fn(acc, x) { acc + x })
}
