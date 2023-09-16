import 'package:args/args.dart';
import 'dart:io';

class CliArgsManager {
  final List<String> args;
  late ArgResults _parsedArgs;

  CliArgsManager(this.args) {
    _initializeParser();
  }

  void _initializeParser() {
    final parser = ArgParser()
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

    try {
      _parsedArgs = parser.parse(args);
    } catch (e) {
      // We do this here, as the arg parsing is the first thing that happens
      stderr.writeln('Error parsing arguments: ${e.toString()}');
    }
  }

  String? get inputFile => _parsedArgs['inputFile'] as String?;
  String? get outputFile => _parsedArgs['outputFile'] as String?;
  String? get logFile => _parsedArgs['logFile'] as String?;
  String? get logLevel => _parsedArgs['logLevel'] as String?;
  String? get mode => _parsedArgs['mode'] as String?;
}
