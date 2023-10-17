import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/17

int containerComboLength(List<int> arr, int sum) {
  List<List<int>> ans = combinationSum(arr, sum);

  if (ans.isEmpty) {
    return throw ('No combinations found.');
  } else {
    return ans.length;
  }
}

List<List<int>> containerComboShortestList(List<int> arr, int sum) {
  List<List<int>> ans = combinationSum(arr, sum);

  if (ans.isEmpty) {
    return throw ('No combinations found.');
  } else {
    return ans;
  }
}

List<List<int>> combinationSum(List<int> arr, int sum) {
  List<List<int>> ans = [];
  List<int> temp = [];

  arr.sort();

  findNumbers(ans, arr, sum, 0, temp);
  return ans;
}

void findNumbers(
    List<List<int>> ans, List<int> arr, int sum, int index, List<int> temp) {
  if (sum == 0) {
    ans.add(List.from(temp));
    return;
  }

  for (int i = index; i < arr.length; i++) {
    if (sum >= arr[i]) {
      temp.add(arr[i]);
      // Note that the next line has i+1 instead of i to allow
      // reusing the same container size in another instance.
      findNumbers(ans, arr, sum - arr[i], i + 1, temp);
      temp.removeLast(); // backtracking
    }
  }
}

int findShortestLists(List<List<int>> mainList) {
  List<List> smallestLists = [];
  int minLength = mainList[0].length;

  for (var sublist in mainList) {
    if (sublist.length < minLength) {
      // If a smaller list is found, clear the smallestLists and update minLength
      smallestLists.clear();
      smallestLists.add(sublist);
      minLength = sublist.length;
    } else if (sublist.length == minLength) {
      // If a list of equal length is found, simply add it to smallestLists
      smallestLists.add(sublist);
    }
  }
  return smallestLists.length;
}

List<int> parseD17Input(String inputData) {
  return inputData
      .split('\n')
      .where((line) => line.isNotEmpty)
      .map(int.parse)
      .toList();
}

const sum = 150;

class Day17P1Solver extends AoCSolver {
  final String? filePath;

  Day17P1Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }
      var arr = parseD17Input(inputData);
      var ans = containerComboLength(arr, sum);

      return Right('Day17P1Solver: $ans');
    } catch (e) {
      var errorMsg = 'Day17P1Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}

class Day17P2Solver extends AoCSolver {
  final String? filePath;

  Day17P2Solver(StringBuffer? input, this.filePath) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData =
          input?.toString().trim() ?? getStringSync(filePath!).trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }
      var arr = parseD17Input(inputData);

      var originalList = containerComboShortestList(arr, sum);

      var ans = findShortestLists(originalList);
      return Right('Day17P2Solver: $ans');
    } catch (e) {
      var errorMsg = 'Day17P2Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}
