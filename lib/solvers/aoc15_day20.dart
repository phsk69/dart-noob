import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/20

int parseD20Input(String stuff) {
  return int.parse(stuff) ~/ 10;
}

class Day20P1Solver extends AoCSolver {
  final String? filePath;

  Day20P1Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString().trim() ?? filePath!.trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      int puzzle = parseD20Input(inputData);

      return Right('Day20P1Solver: ${_solvePuzzle(puzzle)}');
    } catch (e) {
      var errorMsg = 'Day20P1Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }

  int _solvePuzzle(int puzzle) {
    int min = 1, max = puzzle;
    while (min < max) {
      int mid = min + ((max - min) ~/ 2);
      if (mid < 3) break;
      if (_robin(mid) > puzzle) {
        max = mid;
      } else {
        min = mid + 1;
      }
    }

    while (_sigma(min, 0) < puzzle) {
      min += 1;
    }
    return min;
  }

  static const double _eulerMascheroni =
      0.57721566490153286060651209008240243104215933593992;

  double _robin(int n) {
    double lln = log(log(n));
    return exp(_eulerMascheroni) * n * lln + 0.6483 * n / lln;
  }

  final _sigmaCache = <String, int>{};

  double _sigma(int p, int k) {
    String key = '$p,$k';
    if (_sigmaCache.containsKey(key)) {
      return _sigmaCache[key]!.toDouble();
    }

    if (k != 0) {
      _sigmaCache[key] = (pow(p, k + 1) - 1) ~/ (p - 1);
    } else {
      var powers = <int, int>{};
      _factorize(p, powers);
      _sigmaCache[key] = 1;
      for (var base in powers.keys) {
        _sigmaCache[key] =
            _sigmaCache[key]! * _sigma(base, powers[base]!).toInt();
      }
    }
    return _sigmaCache[key]!.toDouble();
  }

  void _factorize(int n, Map<int, int> powers) {
    _sieve(sqrt(n).toInt() + 1);
    for (var p in _primes.keys) {
      while (n % p == 0) {
        n ~/= p;
        powers[p] = (powers[p] ?? 0) + 1;
      }
      if (n == 1) break;
    }
    if (n > 1) powers[n] = (powers[n] ?? 0) + 1;
  }

  var _primes = <int, int>{};
  var _primesLastUntil = 0;
  var _primesLastMul = <int, int>{};

  void _sieve(int until) {
    if (_primesLastUntil == 0) {
      _primes = {2: 1, 3: 1, 5: 1, 7: 1};
      _primesLastMul = {2: 8, 3: 9, 5: 10, 7: 7};
      _primesLastUntil = 10;
    }
    if (until <= _primesLastUntil) return;

    for (var i = _primesLastUntil + 1; i <= until; i++) {
      _primes[i] = 1;
    }
    int sq = sqrt(until).toInt() + 1;
    for (var i = 2; i <= sq; i++) {
      if (_primes.containsKey(i)) {
        var x = _primesLastMul[i] ?? 0; // Add null check
        while ((x += i) <= until) {
          _primes.remove(x);
        }
        _primesLastMul[i] = x - i;
      }
    }
    _primesLastUntil = until;
  }
}

class Day20P2Solver extends AoCSolver {
  final String? filePath;

  Day20P2Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      int targetPresents = int.parse(inputData);
      int houseNumber = findHouse(targetPresents);

      return Right('Day20P2Solver: $houseNumber');
    } catch (e) {
      var errorMsg = 'Day20P2Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }

  int findHouse(int target) {
    int house = 1;
    List<int> presents = List.filled(target ~/ 10 + 1, 0);

    for (int elf = 1; elf <= target ~/ 10; elf++) {
      int housesVisited = 0;
      for (int h = elf; h <= target ~/ 10 && housesVisited < 50; h += elf) {
        presents[h] += elf * 11;
        housesVisited++;
      }
    }

    for (; house <= target ~/ 10; house++) {
      if (presents[house] >= target) {
        break;
      }
    }

    return house;
  }
}
