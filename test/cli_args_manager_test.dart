import 'package:test/test.dart';
import 'package:dart_noob/util/cli_args_manager.dart';

void main() {
  group('CliArgsManager', () {
    test('parses help flag correctly', () {
      var cliArgsManager = CliArgsManager(['-h']);

      expect(cliArgsManager.isHelpFlagSet, isTrue);
      expect(cliArgsManager.mode, isNull);
      expect(cliArgsManager.inputFile, isNull);
      expect(cliArgsManager.outputFile, isNull);
      expect(cliArgsManager.logFile, isNull);
      expect(cliArgsManager.logLevel, isNull);
    });

    test('parses input file option correctly', () {
      var cliArgsManager = CliArgsManager(['-i', 'input.txt']);

      expect(cliArgsManager.inputFile, equals('input.txt'));
    });

    test('parses output file option correctly', () {
      var cliArgsManager = CliArgsManager(['-o', 'output.txt']);

      expect(cliArgsManager.outputFile, equals('output.txt'));
    });

    test('parses log file option correctly', () {
      var cliArgsManager = CliArgsManager(['-l', 'log.txt']);

      expect(cliArgsManager.logFile, equals('log.txt'));
    });

    test('parses log level option correctly', () {
      var cliArgsManager = CliArgsManager(['-v', 'WARNING']);

      expect(cliArgsManager.logLevel, equals('WARNING'));
    });

    test('parses mode option correctly', () {
      var cliArgsManager = CliArgsManager(['-m', 'test_mode']);

      expect(cliArgsManager.mode, equals('test_mode'));
    });

    test('parses multiple options correctly', () {
      var cliArgsManager = CliArgsManager([
        '-i',
        'input.txt',
        '-o',
        'output.txt',
        '-l',
        'log.txt',
        '-v',
        'WARNING',
        '-m',
        'test_mode'
      ]);

      expect(cliArgsManager.inputFile, equals('input.txt'));
      expect(cliArgsManager.outputFile, equals('output.txt'));
      expect(cliArgsManager.logFile, equals('log.txt'));
      expect(cliArgsManager.logLevel, equals('WARNING'));
      expect(cliArgsManager.mode, equals('test_mode'));
    });
  });
}
