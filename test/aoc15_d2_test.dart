import 'package:test/test.dart';
import 'package:dart_noob/d2/aoc15_d2.dart';

void main() {
  group('aoc15_d2', () {
    const String inputPath = 'data/aoc2015_day2_input';
    const int expected = 1606483;
    test('checks aoc d2 p1 copilot for correctness', () async {
      var copilotList = await getInputByLine(inputPath);
      var result = solveAocD2P1CoPilot(copilotList);
      expect(result, expected);
    });

    test('checks aoc d2 p1 listoflists for correctness', () async {
      var listOfListsContent = await getParsedList(inputPath);
      var d1P1 = solveAocD2P1ListOfLists(listOfListsContent);
      expect(d1P1, expected);
    });

    test('checks aoc d2 p1 functional listoflists for correctness', () async {
      var listOfListsContent = await getParsedList(inputPath);
      var result = solveAocD2P1FunctionalListOfLists(listOfListsContent);
      expect(result, expected);
    });

    test('checks aoc d2 p1 functional strings for correctness', () async {
      var listOfStringsContent = await getInputByLine(inputPath);
      var result = solveAocD2P1FunctionalFromStrings(listOfStringsContent);
      expect(result, expected);
    });

    test('checks aoc d2 p1 parallel for correctness', () async {
      var listOfListsContent = await getParsedList(inputPath);
      var result = await solveAocD2P1Parallel(listOfListsContent, 2);
      expect(result, expected);
    });
  });
}
