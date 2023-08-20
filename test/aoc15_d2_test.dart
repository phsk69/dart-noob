import 'package:test/test.dart';
import 'package:dart_noob/aoc15_d2.dart';

void main() {
  group('aoc15_d2', () {
    const String inputPath = 'data/aoc2015_day2_input';
    test('checks aoc d2 p1 copilot for correctness', () {
      const int expected = 1606483;
      expect(() async {
        var copilotList = await getInputByLine(inputPath);
        var d1P1 = await solveAocD2P1CoPilot(copilotList);
        expect(d1P1, expected);
      }, returnsNormally);
    });
    test('checks aoc d2 p1 homebrew for correctness', () {
      const int expected = 1606483;
      expect(() async {
        var homebrewList = await getParsedList(inputPath);
        var d1P1 = await solveAocD2P1HomeBrew(homebrewList);
        expect(d1P1, expected);
      }, returnsNormally);
    });
  });
}
