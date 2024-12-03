import gleam/int
import gleam/string
import simplifile

pub fn read_input(day: Int) -> Result(String, String) {
  let day_str = int.to_string(day)
  let path =
    string.concat(["input/day", string.pad_start(day_str, 2, "0"), ".txt"])
  case simplifile.read(path) {
    Ok(content) -> Ok(content)
    Error(e) -> Error("Failed to read input file: " <> string.inspect(e))
  }
}
