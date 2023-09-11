# dart_noob

## Doing

- [ ] cat data/aoc2015_day1_input | ./aoc2015 -m d1 hits the default mode case on linux
- [ ] Figure out a way to handle the outer execptions when files and folders etc do not exist.
- [ ] Converting to the cli way

## Ideas

- [ ] If multiple inputs are defined, do some magic check to see if the checksum of both are the same and then prefer input file if true

## Bugs
```bash
cat data/aoc2015_day1_input | dart run bin/aoc2015.dart -i data/aoc2015_day1_input -o output/out.txt
# output
Using output/out.txt as output file
Input: data/aoc2015_day1_input
Mode not specified with an input file provided.

# It has to error out when both are defined.
```
