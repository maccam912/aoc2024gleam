import gleam/io
import gleam/int
import day01
import day02
import utils

pub fn main() {
  io.println("Advent of Code 2024 - Gleam Solutions\n")

  // Run Day 1
  case utils.read_input(1) {
    Ok(input) -> {
      let parsed = day01.parse_input(input)
      io.println("Day 1:")
      io.println("Part 1: " <> int.to_string(day01.part1(parsed)))
      io.println("Part 2: " <> int.to_string(day01.part2(parsed)))
    }
    Error(e) -> io.println("Day 1: " <> e)
  }

  // Run Day 2
  case utils.read_input(2) {
    Ok(input) -> {
      let parsed = day02.parse_input(input)
      io.println("\nDay 2:")
      io.println("Part 1: " <> int.to_string(day02.part1(parsed)))
      io.println("Part 2: " <> int.to_string(day02.part2(parsed)))
    }
    Error(e) -> io.println("\nDay 2: " <> e)
  }
}
