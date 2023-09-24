import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/6

class Day6P1Solver extends AoCSolver {
  final String? filePath;

  Day6P1Solver(StringBuffer? input, [this.filePath]) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString() ?? getStringSync(filePath!);
      if (inputData.trim().isEmpty) {
        return Left('Input is empty.');
      }

      final int width = 1000;
      final int height = 1000;

      List<List<int>> grid = List.generate(height, (y) {
        return List.generate(width, (x) {
          return 0;
        });
      });

      for (var line in inputData.split('\n').where((line) => line.isNotEmpty)) {
        var instruction = line.split(' ');
        String action;
        List<String> start;
        List<String> end;

        if (instruction[0] == "toggle") {
          action = "toggle";
          start = instruction[1].split(',');
          end = instruction[3].split(',');
        } else {
          action = instruction[1]; // "on" or "off"
          start = instruction[2].split(',');
          end = instruction[4].split(',');
        }

        var startX = int.parse(start[0]);
        var startY = int.parse(start[1]);
        var endX = int.parse(end[0]);
        var endY = int.parse(end[1]);

        for (var y = startY; y <= endY; y++) {
          for (var x = startX; x <= endX; x++) {
            switch (action) {
              case 'on':
                grid[y][x] = 1;
                break;
              case 'off':
                grid[y][x] = 0;
                break;
              case 'toggle':
                grid[y][x] = grid[y][x] == 0 ? 1 : 0;
                break;
            }
          }
        }
      }
      int turnedOnLights =
          grid.expand((i) => i).where((cell) => cell == 1).length;

      return Right('Day6P1Solver: $turnedOnLights');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
