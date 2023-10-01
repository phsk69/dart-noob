import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/13

class Day13P1Solver extends AoCSolver {
  final String? filePath;

  Day13P1Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.trim().isEmpty) {
        return Left('Input is empty.');
      }
      List<Map<String, Object>> guests = []; // Updated type to Object

      for (var line in inputData.split('\n').where((line) => line.isNotEmpty)) {
        List<String> words = line.split(' ');
        if (words.length == 11) {
          var guestName = words[0];
          var neighborName = words[10]
              .substring(0, words[10].length - 1);
          var happinessChange = int.parse(words[3]);

          if (words[2] == 'gain') {
            if (guests.isEmpty) {
              guests.add({
                'guest': guestName,
                'preferences': <String, int>{neighborName: happinessChange}
              });
            } else {
              var existingGuest = guests.firstWhere(
                (guest) => guest['guest'] == guestName,
                orElse: () => {
                  'guest': guestName,
                  'preferences': <String, int>{}
                },
              );

              if (existingGuest != null) {
                existingGuest['preferences'][neighborName] = happinessChange;
              } else {
                guests.add({
                  'guest': guestName,
                  'preferences': <String, int>{neighborName: happinessChange}
                });
              }
            }
          }
        }
      }

      // Now 'guests' list contains guest information with their preferences
      // Continue with the rest of your logic

      return Right('Day13P1Solver: placeholder');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

      // Now 'guests' list contains guest information with their preferences
      // Continue with the rest of your logic

      return Right('Day13P1Solver: placeholder');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

class Day13P2Solver extends AoCSolver {
  final String? filePath;

  Day13P2Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.trim().isEmpty) {
        return Left('Input is empty.');
      }

      return Right('Day13P2Solver: placeholder');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
