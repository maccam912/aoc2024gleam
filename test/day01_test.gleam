import gleeunit
import gleeunit/should
import day01

pub fn main() {
  gleeunit.main()
}

pub fn example_input() -> String {
  "3 4\n4 3\n2 5\n1 3\n3 9\n3 3"
}

pub fn part1_test() {
  day01.part1(example_input())
  |> should.equal(11)
}

pub fn part2_test() {
  day01.part2(example_input())
  |> should.equal(31)
}
