import day03
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn example_input_test() {
  // Test the example from the problem description
  "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
  |> day03.part1
  |> should.equal(161)
}

pub fn empty_input_test() {
  ""
  |> day03.part1
  |> should.equal(0)
}

pub fn no_multiplications_test() {
  "no multiplications here"
  |> day03.part1
  |> should.equal(0)
}

pub fn invalid_multiplications_test() {
  "mul(a,b)mul(1,)mul(,2)mul()"
  |> day03.part1
  |> should.equal(0)
}

pub fn multiple_lines_test() {
  "mul(2,3)\nmul(4,5)\nmul(6,7)"
  |> day03.part1
  |> should.equal(6 + 20 + 42)
}

pub fn overlapping_multiplications_test() {
  "mul(2,3)mul(4,5)"
  |> day03.part1
  |> should.equal(26)
}

pub fn spaces_in_multiplication_test() {
  "mul ( 2 , 3 )"
  |> day03.part1
  |> should.equal(0)
  // Should not match due to spaces
}

pub fn large_numbers_test() {
  "mul(123,456)"
  |> day03.part1
  |> should.equal(123 * 456)
}
