import 'package:test/test.dart';
import 'package:dart_noob/solvers/aoc15_day19.dart';

// TODO: Convert this to use the data library
void main() {
  group('Day19P1Solver', () {
    test(
        'computes the correct number of distinct molecules with provided input',
        () {
      StringBuffer buffer = StringBuffer('H => HO\n'
          'H => OH\n'
          'O => HH\n'
          '\n'
          'HOH');
      var solver = Day19P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day19P1Solver: 4');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day19P1Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    test('computes the correct number of distinct molecules with input file',
        () {
      var solver = Day19P1Solver(null, 'data/aoc2015_day19_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day19P1Solver: 518');
    });
  });

  group('Day19P2Solver', () {
    test('computes the fewest number of steps with provided input', () {
      StringBuffer buffer = StringBuffer('Al => ThF\n'
          'Al => ThRnFAr\n'
          'B => BCa\n'
          'B => TiB\n'
          'B => TiRnFAr\n'
          'Ca => CaCa\n'
          'Ca => PB\n'
          'Ca => PRnFAr\n'
          'Ca => SiRnFYFAr\n'
          'Ca => SiRnMgAr\n'
          'Ca => SiTh\n'
          'F => CaF\n'
          'F => PMg\n'
          'F => SiAl\n'
          'H => CRnAlAr\n'
          'H => CRnFYFYFAr\n'
          'H => CRnFYMgAr\n'
          'H => CRnMgYFAr\n'
          'H => HCa\n'
          'H => NRnFYFAr\n'
          'H => NRnMgAr\n'
          'H => NTh\n'
          'H => OB\n'
          'H => ORnFAr\n'
          'Mg => BF\n'
          'Mg => TiMg\n'
          'N => CRnFAr\n'
          'N => HSi\n'
          'O => CRnFYFAr\n'
          'O => CRnMgAr\n'
          'O => HP\n'
          'O => NRnFAr\n'
          'O => OTi\n'
          'P => CaP\n'
          'P => PTi\n'
          'P => SiRnFAr\n'
          'Si => CaSi\n'
          'Th => ThCa\n'
          'Ti => BP\n'
          'Ti => TiTi\n'
          'e => HF\n'
          'e => NAl\n'
          'e => OMg\n'
          '\n'
          'CRnSiRnCaPTiMgYCaPTiRnFArSiThFArCaSiThSiThPBCaCaSiRnSiRnTiTiMgArPBCaPMgYPTiRnFArFArCaSiRnBPMgArPRnCaPTiRnFArCaSiThCaCaFArPBCaCaPTiTiRnFArCaSiRnSiAlYSiThRnFArArCaSiRnBFArCaCaSiRnSiThCaCaCaFYCaPTiBCaSiThCaSiThPMgArSiRnCaPBFYCaCaFArCaCaCaCaSiThCaSiRnPRnFArPBSiThPRnFArSiRnMgArCaFYFArCaSiRnSiAlArTiTiTiTiTiTiTiRnPMgArPTiTiTiBSiRnSiAlArTiTiRnPMgArCaFYBPBPTiRnSiRnMgArSiThCaFArCaSiThFArPRnFArCaSiRnTiBSiThSiRnSiAlYCaFArPRnFArSiThCaFArCaCaSiThCaCaCaSiRnPRnCaFArFYPMgArCaPBCaPBSiRnFYPBCaFArCaSiAl');
      var solver = Day19P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Day19P2Solver: 200');
    });

    test('ignores empty input', () {
      StringBuffer buffer = StringBuffer('');
      var solver = Day19P2Solver(buffer, null);

      var result = solver.solve();

      expect(result.isLeft(), true);
    });

    // Example test that uses a file for input.
    test('computes the fewest number of steps with input file', () {
      var solver = Day19P2Solver(null, 'data/aoc2015_day19_input.txt');

      var result = solver.solve();

      expect(result.isRight(), true);
      // Update expected value based on actual results when using the input file.
      expect(result.getOrElse(() => ''), 'Day19P2Solver: 200');
    });
  });
}
