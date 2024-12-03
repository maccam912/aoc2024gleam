import gleeunit
import gleeunit/should
import day01.{Input}

pub fn main() {
  gleeunit.main()
}

pub fn example_input() {
  "3\t4
4\t3
2\t5
1\t3
3\t9
3\t3"
}

pub fn parse_test() {
  let Input(left: left, right: right) = day01.parse_input(example_input())
  left
  |> should.equal([3, 4, 2, 1, 3, 3])
  right
  |> should.equal([4, 3, 5, 3, 9, 3])
}

pub fn part1_test() {
  day01.parse_input(example_input())
  |> day01.part1
  |> should.equal(11)
}

pub fn part2_test() {
  day01.parse_input(example_input())
  |> day01.part2
  |> should.equal(31)
}
