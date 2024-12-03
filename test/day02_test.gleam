import day02
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn example_input() {
  "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"
}

pub fn parse_test() {
  day02.parse_input(example_input())
  |> should.equal([
    [7, 6, 4, 2, 1],
    [1, 2, 7, 8, 9],
    [9, 7, 6, 2, 1],
    [1, 3, 2, 4, 5],
    [8, 6, 4, 4, 1],
    [1, 3, 6, 7, 9],
  ])
}

pub fn is_safe_test() {
  day02.is_safe([7, 6, 4, 2, 1])
  |> should.equal(True)

  day02.is_safe([1, 2, 7, 8, 9])
  |> should.equal(False)

  day02.is_safe([9, 7, 6, 2, 1])
  |> should.equal(False)

  day02.is_safe([1, 3, 2, 4, 5])
  |> should.equal(False)

  day02.is_safe([8, 6, 4, 4, 1])
  |> should.equal(False)

  day02.is_safe([1, 3, 6, 7, 9])
  |> should.equal(True)
}

pub fn part1_test() {
  day02.parse_input(example_input())
  |> day02.part1
  |> should.equal(2)
}

pub fn part2_test() {
  day02.parse_input(example_input())
  |> day02.part2
  |> should.equal(4)
}
