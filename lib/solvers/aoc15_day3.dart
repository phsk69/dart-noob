import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/3

class Day3P1Solver extends AoCSolver {
  final String? filePath;

  Day3P1Solver(super.input, [this.filePath]);

  @override
  Either<String, String> solve() {
    try {
      String content;

      if (input != null) {
        content = input.toString().replaceAll(RegExp(r'\s'), '');
      } else if (filePath != null) {
        content = getStringSync(filePath!).replaceAll(RegExp(r'\s'), '');
      } else {
        return Left("No input provided.");
      }

      int result = SantaRouter(content.split('')).computeVisitedPositions();
      return Right('Day3P1Solver: $result');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

class Day3P2Solver extends AoCSolver {
  final String? filePath;

  Day3P2Solver(super.input, [this.filePath]);

  @override
  Either<String, String> solve() {
    try {
      String content;

      if (input != null) {
        content = input.toString().replaceAll(RegExp(r'\s'), '');
      } else if (filePath != null) {
        content = getStringSync(filePath!).replaceAll(RegExp(r'\s'), '');
      } else {
        return Left("No input provided.");
      }
      const int actors = 2;
      int result =
          SantaRouter(content.split('')).computeVisitedPositionsSplit(actors);
      return Right('Day3P2Solver: $result');
    } catch (e) {
      return Left(e.toString());
    }
  }
}

class SantaRouter {
  final List<String> moves;
  final Map<String, int> visitedPositions = {};

  SantaRouter(this.moves);

  /// Marks the current position as visited by incrementing its count.
  void _visitPosition(int x, int y) {
    String key = '$x,$y';
    visitedPositions[key] = (visitedPositions[key] ?? 0) + 1;
  }

  /// This is the correct way of splitting and grouping where each
  /// actor takes turns making moves ie. alternating by actors
  List<List<String>> splitAlternatingMoves(List<String> moves, int actors) {
    List<List<String>> result = List.generate(actors, (index) => <String>[]);

    for (var i = 0; i < moves.length; i++) {
      result[i % actors].add(moves[i]);
    }

    return result;
  }

  /// Computes the total number of unique pos visited by moves.
  int computeVisitedPositionsSplit(int actors) {
    var splitList = splitAlternatingMoves(moves, actors);

    for (var moveset in splitList) {
      int x = 0;
      int y = 0; // Resetting position for each actor
      _visitPosition(x, y); // Each actor marks the starting position
      for (var move in moveset) {
        switch (move) {
          case '^':
            y += 1;
            break;
          case 'v':
            y -= 1;
            break;
          case '<':
            x -= 1;
            break;
          case '>':
            x += 1;
            break;
          default:
            throw Exception("Invalid move character: $move");
        }
        _visitPosition(x, y);
      }
    }
    return visitedPositions.length;
  }

  /// Computes the total number of unique pos visited by moves.
  int computeVisitedPositions() {
    int x = 0;
    int y = 0;
    _visitPosition(x, y);

    for (var move in moves) {
      switch (move) {
        case '^':
          y += 1;
          break;
        case 'v':
          y -= 1;
          break;
        case '<':
          x -= 1;
          break;
        case '>':
          x += 1;
          break;
        default:
          throw Exception("Invalid move character: $move");
      }
      _visitPosition(x, y);
    }

    return visitedPositions.length;
  }
}
