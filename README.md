# dart_noob

A project for solving AOC2015 and learning dart along the way

## Setup

### Requirements

- Dart SDK: 3.1.X+
- lcov: 2.X+ (For `tests.sh`)
- A default HTML viewer (For `tests.sh`)

### Prepare dart project

``` bash
dart pub get
```

## Usage examples

### Print help

```bash
./aoc2015 -h
```

#### Example output

```text
➜  dart_noob git:(feature/aoc2015) ✗ ./aoc2015 -h
Usage: aoc2015 [options]
-h, --help          Displays this help information.
-i, --inputFile     Specify the path of the input file
-o, --outputFile    Specify the file to write output
-l, --logFile       Specify the file to log messages
-v, --logLevel      Specify the logging level (default is INFO)
                    [ALL, OFF, FINE, INFO, WARNING, SEVERE, SHOUT]
-m, --mode          Mode of operation
```

### Run a specific day, output to stdout only

```bash
./aoc2015 -m d21 -i data/aoc2015_day21_input.txt 
```

#### Example output for a specific day

```text
➜  dart_noob git:(feature/aoc2015) ✗ ./aoc2015 -m d21 -i data/aoc2015_day21_input.txt 
Input: data/aoc2015_day21_input.txt
Mode: d21
Day21P1Solver: 111
Day21P2Solver: 188
```

### Log to file

#### With default log level (INFO)

```bash
./aoc2015 -m d21 -i data/aoc2015_day21_input.txt -l output/log.log
```

#### Example log structure

```text
➜  dart_noob git:(feature/aoc2015) ✗ cat output/log.log
2023-10-17T17:09:57.820346Z - INFO - Log: output/log.log
2023-10-17T17:09:57.820550Z - INFO - Input: data/aoc2015_day21_input.txt
2023-10-17T17:09:57.821081Z - INFO - Day21P1Solver: 111
2023-10-17T17:09:57.821155Z - INFO - Day21P2Solver: 188
```

#### With ALL log level

```bash
./aoc2015 -m d21 -i data/aoc2015_day21_input.txt -l output/log.log -v ALL
```

### Output to file

```bash
./aoc2015 -m d21 -i data/aoc2015_day21_input.txt -o output/output.txt
```

#### Example output structure

```text
➜  dart_noob git:(feature/aoc2015) ✗ cat output/output.txt
Input: data/aoc2015_day21_input.txt
Output: output/output.txt
Mode: d21
Day21P1Solver: 111
```

## Dev tools

- `build.sh`: Builds the aoc2015 executable and runs all the days with only the required arguments
- `docs.sh`: Generates API documentation through `dart doc` and opens the resulting html via syscall
- `ship.sh`
  - Builds the project
  - Generates a fresh set of doc files with `dart doc`
  - Stages the entire project in git and pushes it with 'auto commit' as commit msg
