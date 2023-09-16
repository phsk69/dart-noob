import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:dart_noob/util/handlers.dart';
import 'package:dart_noob/util/sink_manager.dart';
import 'package:dart_noob/util/output_manager.dart';

class CliArgsManager {
  final List<String> args;
  final SinkManager sinkManager;
  late Logger logger;
  late OutputManager outputManager;
  late ArgResults _parsedArgs;

  CliArgsManager(this.args, this.sinkManager) {
    _initializeParser();
  }

  void setLogger(Logger newLogger) {
    logger = newLogger;
  }

  void setOutputManager(OutputManager newOutputManager) {
    outputManager = newOutputManager;
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
      handleExitWithError(
          'Argument parsing failed: $e', sinkManager, logger, outputManager);
    }
  }

  String? get inputFile => _parsedArgs['inputFile'] as String?;
  String? get outputFile => _parsedArgs['outputFile'] as String?;
  String? get logFile => _parsedArgs['logFile'] as String?;
  String? get logLevel => _parsedArgs['logLevel'] as String?;
  String? get mode => _parsedArgs['mode'] as String?;
}
