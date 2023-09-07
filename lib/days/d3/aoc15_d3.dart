import 'package:dart_noob/util/string_stuff.dart';

// https://adventofcode.com/2015/day/3

/// Computes the number of unique positions visited based on Santa's moves.
///
/// Fetches the moves from the given [inputPath] and computes the result.
Future<int> solveAoc15D3P1(String inputPath) async {
  try {
    var input = await getInputString(inputPath);
    return SantaRouter(input).computeVisitedPositions();
  } catch (e) {
    throw 'solveAoc15D3P1: $e';
  }
}

Future<int> solveAoc15D3P2(String inputPath) async {
  try {
    var input = await getInputString(inputPath);
    return SantaRouter(input).computeVisitedPositionsSplit(2);
  } catch (e) {
    throw 'solveAoc15D3P1: $e';
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

  /// Splits moves into N amount of chunks
  /// This did not work, as i forgot to group the moves correctly
  /*
  List<List<String>> _splitMoves(List<String> moves, int chunkCount) {
    List<List<String>> chunks = [];
    int chunkSize = moves.length ~/ chunkCount; // Integer division
    for (var i = 0; i < moves.length; i += chunkSize) {
      chunks.add(moves.sublist(
          i, i + chunkSize > moves.length ? moves.length : i + chunkSize));
    }
    return chunks;
  }
  */

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
      }
      _visitPosition(x, y);
    }

    return visitedPositions.length;
  }
}
