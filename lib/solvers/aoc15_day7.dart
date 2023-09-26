import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/7

class Day7P1Solver extends AoCSolver {
  final String? filePath;

  Day7P1Solver(StringBuffer? input, [this.filePath]) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString() ?? getStringSync(filePath!);
      if (inputData.trim().isEmpty) {
        return Left('Input is empty.');
      }
      Map<String, int> wires = Map<String, int>();
      List<String> operations = [];
      for (var line in inputData.split('\n').where((line) => line.isNotEmpty)) {
        var instruction = line.split(' ');
        if (instruction.length == 3) {
          // Assignment operation
          var value = getValue(instruction[0], wires);
          if (value != null) {
            wires[instruction[2]] = value & 0xFFFF;
          } else {
            operations.add(line);
          }
        } else if (instruction.length == 4) {
          // Unary operation
          var value = getValue(instruction[1], wires);
          if (value != null) {
            wires[instruction[3]] = ~value & 0xFFFF;
          } else {
            operations.add(line);
          }
        } else if (instruction.length == 5) {
          // Binary operation
          var value1 = getValue(instruction[0], wires);
          var value2 = getValue(instruction[2], wires);
          if (value1 != null && value2 != null) {
            switch (instruction[1]) {
              case 'AND':
                wires[instruction[4]] = (value1 & value2) & 0xFFFF;
                break;
              case 'OR':
                wires[instruction[4]] = (value1 | value2) & 0xFFFF;
                break;
              case 'LSHIFT':
                wires[instruction[4]] = (value1 << value2) & 0xFFFF;
                break;
              case 'RSHIFT':
                wires[instruction[4]] = (value1 >> value2) & 0xFFFF;
                break;
            }
          } else {
            operations.add(line);
          }
        }
      }
      // Process all operations until there are no more to process
      bool progressMade;
      do {
        progressMade = false;
        List<String> toRemove = [];

        for (var operation in operations) {
          var instruction = operation.split(' ');
          bool executed = false;

          if (instruction.length == 3) {
            // Assignment operation
            var value = getValue(instruction[0], wires);
            if (value != null) {
              wires[instruction[2]] = value & 0xFFFF;
              executed = true;
            }
          } else if (instruction.length == 4) {
            // Unary operation
            var value = getValue(instruction[1], wires);
            if (value != null) {
              wires[instruction[3]] = ~value & 0xFFFF;
              executed = true;
            }
          } else if (instruction.length == 5) {
            // Binary operation
            var value1 = getValue(instruction[0], wires);
            var value2 = getValue(instruction[2], wires);
            if (value1 != null && value2 != null) {
              switch (instruction[1]) {
                case 'AND':
                  wires[instruction[4]] = (value1 & value2) & 0xFFFF;
                  break;
                case 'OR':
                  wires[instruction[4]] = (value1 | value2) & 0xFFFF;
                  break;
                case 'LSHIFT':
                  wires[instruction[4]] = (value1 << value2) & 0xFFFF;
                  break;
                case 'RSHIFT':
                  wires[instruction[4]] = (value1 >> value2) & 0xFFFF;
                  break;
              }
              executed = true;
            }
          }

          if (executed) {
            toRemove.add(operation);
            progressMade = true;
          }
        }

        // Remove successfully executed operations from the list
        for (var operation in toRemove) {
          operations.remove(operation);
        }
      } while (progressMade && operations.isNotEmpty);
      return Right('Day7P1Solver: ${wires['a']}');
    } catch (e) {
      return Left(e.toString());
    }
  }

  int? getValue(String wire, Map<String, int> wires) {
    if (int.tryParse(wire) != null) {
      // The wire is a constant value
      return int.parse(wire);
    } else if (wires.containsKey(wire)) {
      // The wire is already defined
      return wires[wire];
    } else {
      // The wire is not defined yet
      return null;
    }
  }
}
