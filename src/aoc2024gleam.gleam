import day01
import day02
import day03
import gleam/int
import gleam/io
import simplifile
import utils

pub fn main() {
  io.println("Advent of Code 2024 - Gleam Solutions\n")

  // Run Day 1
  case utils.read_input(1) {
    Ok(input) -> {
      io.println("Day 1:")
      io.println("Part 1: " <> int.to_string(day01.part1(input)))
      io.println("Part 2: " <> int.to_string(day01.part2(input)))
      io.println("")
    }
    Error(e) -> io.println("Day 1: " <> e)
  }

  // Run Day 2
  case utils.read_input(2) {
    Ok(input) -> {
      io.println("Day 2:")
      io.println("Part 1: " <> int.to_string(day02.part1(input)))
      io.println("Part 2: " <> int.to_string(day02.part2(input)))
      io.println("")
    }
    Error(e) -> io.println("Day 2: " <> e)
  }

  // Run Day 3
  case utils.read_input(3) {
    Ok(input) -> {
      io.println("Day 3:")
      io.println("Part 1: " <> int.to_string(day03.part1(input)))
      io.println("Part 2: " <> int.to_string(day03.part2(input)))
      io.println("")
    }
    Error(e) -> io.println("Day 3: " <> e)
  }
}
