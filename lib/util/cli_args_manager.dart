import 'package:args/args.dart';
import 'dart:io';

class CliArgsManager {
  final List<String> args;
  ArgResults? _parsedArgs;
  final ArgParser _parser = ArgParser();

  CliArgsManager(this.args) {
    try {
      _initializeParser();
    } catch (e) {
      stderr.writeln('Error initializing parser: ${e.toString()}');
      exit(1);
    }
  }

  void _initializeParser() {
    _parser
      ..addFlag('help',
          abbr: 'h', negatable: false, help: 'Displays this help information.')
      ..addOption('inputFile',
          abbr: 'i', help: 'Specify the path of the input file')
      ..addOption('outputFile',
          abbr: 'o', help: 'Specify the file to write output')
      ..addOption('logFile',
          abbr: 'l', help: 'Specify the file to log messages')
      ..addOption('logLevel',
          abbr: 'v',
          help: 'Specify the logging level (default is INFO)',
          allowed: ['ALL', 'OFF', 'FINE', 'INFO', 'WARNING', 'SEVERE', 'SHOUT'])
      ..addOption('mode', abbr: 'm', help: 'Mode of operation');

    _parsedArgs = _parser.parse(args); // ArgResults? is nullable now
  }

  void handleHelpFlag() {
    if (_parsedArgs!['help'] as bool) {
      printUsage();
      exit(0);
    }
  }

  void printUsage() {
    print('Usage: aoc2015 [options]');
    print(_parser.usage); // This will print the detailed help information.
  }

  bool get isHelpFlagSet => _parsedArgs?['help'] as bool? ?? false;
  String? get inputFile => _parsedArgs?['inputFile'] as String?;
  String? get outputFile => _parsedArgs?['outputFile'] as String?;
  String? get logFile => _parsedArgs?['logFile'] as String?;
  String? get logLevel => _parsedArgs?['logLevel'] as String?;
  String? get mode => _parsedArgs?['mode'] as String?;
}
