# Advent of Code 2024 - Gleam Solutions

Solutions for [Advent of Code 2024](https://adventofcode.com/2024) implemented in [Gleam](https://gleam.run/).

## Project Structure

- `src/`: Contains the solution implementations
  - `day01.gleam`: Solution for Day 1 - Historian Hysteria
  - `day02.gleam`: Solution for Day 2 - Red-Nosed Reports
  - `utils.gleam`: Utility functions for reading input files
  - `main.gleam`: Main program to run all solutions
- `test/`: Contains the test files
  - `day01_test.gleam`: Tests for Day 1
  - `day02_test.gleam`: Tests for Day 2
- `input/`: Contains the puzzle input files
  - `day01.txt`: Input for Day 1
  - `day02.txt`: Input for Day 2

## Requirements

- [Gleam](https://gleam.run/getting-started/installing/)
- Erlang/OTP 24 or later

## Setup

1. Clone this repository
2. Place your puzzle inputs in the corresponding files in the `input/` directory
   - For example, Day 1's input goes in `input/day01.txt`

## Running Tests

To run all tests:

```bash
gleam test
```

To run tests for a specific day (using Erlang shell):

```bash
gleam erl
> :day01_test.main()  # For Day 1
> :day02_test.main()  # For Day 2
```

## Running Solutions

To run all solutions:
```sh
gleam run
```

Or you can run solutions interactively in the Erlang shell:

```bash
gleam erl
```

Then in the Erlang shell:

```erlang
% Run all solutions
:main.main()

% Or run specific days
Input1 = result.unwrap(:utils.read_input(1), "")
Day1 = :day01.parse_input(Input1)
:day01.part1(Day1)  % Get answer for Part 1
:day01.part2(Day1)  % Get answer for Part 2

Input2 = result.unwrap(:utils.read_input(2), "")
Day2 = :day02.parse_input(Input2)
:day02.part1(Day2)  % Get answer for Part 1
:day02.part2(Day2)  % Get answer for Part 2
```

## Progress

- [x] Day 1: Historian Hysteria
  - [x] Part 1
  - [x] Part 2
- [x] Day 2: Red-Nosed Reports
  - [x] Part 1
  - [x] Part 2
- [x] Day 3: The Tangled Web
  - [x] Part 1
  - [ ] Part 2

# And here I give up...
I didn't quite get part 2 working for day 3, but was falling behind. I had trouble figuring out how to set breakpoints and step through things.