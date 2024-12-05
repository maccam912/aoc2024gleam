import gleam/int
import gleam/io
import gleam/list
import gleam/option
import gleam/regex
import gleam/string

type Instruction {
  Do
  Dont
  Mul(x: Int, y: Int)
}

fn get_match_index(input: String, match: regex.Match) -> Int {
  let parts = string.split(input, match.content)
  case list.first(parts) {
    Ok(first) -> string.length(first)
    Error(_) -> 0
  }
}

fn parse_instructions(input: String) -> List(Instruction) {
  let assert Ok(mul_pattern) =
    regex.from_string("mul\\((\\d{1,3}),(\\d{1,3})\\)")
  let assert Ok(do_pattern) = regex.from_string("do\\(\\)")
  let assert Ok(dont_pattern) = regex.from_string("don't\\(\\)")

  let instructions = []

  // Find all matches for each pattern
  let mul_matches = regex.scan(mul_pattern, input)
  let do_matches = regex.scan(do_pattern, input)
  let dont_matches = regex.scan(dont_pattern, input)

  // Process mul matches
  let mul_instructions =
    list.map(mul_matches, fn(match) {
      let assert [x_str, y_str] = match.submatches
      let assert Ok(x) = int.parse(option.unwrap(x_str, "0"))
      let assert Ok(y) = int.parse(option.unwrap(y_str, "0"))
      #(get_match_index(input, match), Mul(x: x, y: y))
    })

  // Process do matches
  let do_instructions =
    list.map(do_matches, fn(match) { #(get_match_index(input, match), Do) })

  // Process dont matches
  let dont_instructions =
    list.map(dont_matches, fn(match) { #(get_match_index(input, match), Dont) })

  // Combine all instructions and sort by index
  list.concat([mul_instructions, do_instructions, dont_instructions])
  |> list.sort(fn(a, b) { int.compare(a.0, b.0) })
  |> list.map(fn(x) { x.1 })
}

pub fn part1(input: String) -> Int {
  let instructions = parse_instructions(input)

  // Process instructions and accumulate multiplication results
  list.fold(instructions, 0, fn(acc, instruction) {
    case instruction {
      Mul(x: x, y: y) -> acc + x * y
      _ -> acc
    }
  })
}

pub fn part2(input: String) -> Int {
  let instructions = parse_instructions(input)

  // Fold through instructions keeping track of both accumulator and enabled state
  list.fold(
    instructions,
    #(0, True),
    // tuple of (accumulator, enabled)
    fn(state, instruction) {
      let #(acc, enabled) = state
      case instruction {
        // When we see a Dont, disable processing until next Do
        Dont -> #(acc, False)
        // When we see a Do, re-enable processing
        Do -> #(acc, True)
        // For Mul instructions, only add to accumulator if enabled
        Mul(x: x, y: y) ->
          case enabled {
            True -> #(acc + x * y, enabled)
            False -> #(acc, enabled)
          }
      }
    },
  ).0
  // Return just the accumulator from the tuple
}
