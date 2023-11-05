import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/24

List<int> parseD24Input(String d24Input) {
  var lines = d24Input.trim().split('\n');
  return lines.map(int.parse).toList();
}

class PackageBalancer {
  final List<int> packages;

  PackageBalancer(this.packages);

  List<List<int>> _findSubsetsWithSum(List<int> numbers, int target) {
    final List<List<int>> results = [];

    void search(List<int> current, int fromIndex, int currentSum) {
      if (currentSum == target) {
        results.add(List.from(current));
        return;
      }
      if (fromIndex == numbers.length) return;
      if (currentSum + numbers[fromIndex] <= target) {
        current.add(numbers[fromIndex]);
        search(current, fromIndex + 1, currentSum + numbers[fromIndex]);
        current.removeLast();
      }
      search(current, fromIndex + 1, currentSum);
    }

    search([], 0, 0);
    return results;
  }

  int _quantumEntanglement(List<int> group) {
    return group.fold(1, (prev, curr) => prev * curr);
  }

  int findIdealConfigurationQuantumEntanglement({int numberOfGroups = 3}) {
    final int groupWeight = packages.fold(0, (a, b) => a + b) ~/ numberOfGroups;

    for (int i = 1; i <= packages.length / numberOfGroups; i++) {
      final List<List<int>> firstGroupCandidates =
          _findSubsetsWithSum(packages, groupWeight);
      firstGroupCandidates.removeWhere((group) => group.length > i);

      for (var group in firstGroupCandidates) {
        final remainingPackages =
            packages.where((pkg) => !group.contains(pkg)).toList();
        final secondGroupCandidates =
            _findSubsetsWithSum(remainingPackages, groupWeight);

        if (numberOfGroups == 3 && secondGroupCandidates.isNotEmpty) {
          return _quantumEntanglement(group);
        } else {
          for (var secondGroup in secondGroupCandidates) {
            final secondRemainingPackages = remainingPackages
                .where((pkg) => !secondGroup.contains(pkg))
                .toList();
            final thirdGroupCandidates =
                _findSubsetsWithSum(secondRemainingPackages, groupWeight);

            if (thirdGroupCandidates.isNotEmpty) {
              if (numberOfGroups == 4) {
                for (var thirdGroup in thirdGroupCandidates) {
                  final finalRemainingPackages = secondRemainingPackages
                      .where((pkg) => !thirdGroup.contains(pkg))
                      .toList();
                  final fourthGroup =
                      _findSubsetsWithSum(finalRemainingPackages, groupWeight);
                  if (fourthGroup.isNotEmpty) {
                    return _quantumEntanglement(group);
                  }
                }
              }
            }
          }
        }
      }
    }
    return -1; // Indicates no solution found
  }
}

class Day24P1Solver extends AoCSolver {
  final String? filePath;
  final Logger? logger;

  Day24P1Solver(StringBuffer? input, this.filePath, this.logger) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString().trim() ?? filePath!.trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }
      final packages = parseD24Input(inputData);
      final packageBalancer = PackageBalancer(packages);
      final quantumEntanglement =
          packageBalancer.findIdealConfigurationQuantumEntanglement();

      return Right('Day24P1Solver: $quantumEntanglement');
    } catch (e) {
      var errorMsg = 'Day24P1Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}

class Day24P2Solver extends AoCSolver {
  final String? filePath;
  final Logger? logger;

  Day24P2Solver(StringBuffer? input, this.filePath, this.logger) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString().trim() ?? filePath!.trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }
      final packages = parseD24Input(inputData);
      final packageBalancer = PackageBalancer(packages);
      final quantumEntanglement = packageBalancer
          .findIdealConfigurationQuantumEntanglement(numberOfGroups: 4);
      return Right('Day24P2Solver: $quantumEntanglement');
    } catch (e) {
      var errorMsg = 'Day24P2Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}
