import 'dart:async';
import 'dart:io';
import 'package:args/args.dart';
import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
// Replace this import with the actual path of your solvers.
import 'package:dart_noob/days/d1/aoc15_d1.dart';

typedef TaskSolver = Future<Either<String, int>> Function(
    String?, Stream<List<int>>?);

final log = Logger('CLI');

void main(List<String> args) async {
  final parser = ArgParser()
    ..addOption('inputfile',
        abbr: 'i', help: 'Specify the path of the input file')
    ..addOption('errorlog', abbr: 'e', help: 'Specify the file to write errors')
    ..addOption('output', abbr: 'o', help: 'Specify the file to write output')
    ..addOption('logfile', abbr: 'l', help: 'Specify the file to log messages')
    ..addOption('loglevel',
        abbr: 'v',
        help: 'Specify the logging level (default is WARNING)',
        allowed: ['ALL', 'OFF', 'FINE', 'INFO', 'WARNING', 'SEVERE', 'SHOUT'])
    ..addOption('mode', abbr: 'm', help: 'Mode of operation');

  final parsedArgs = parser.parse(args);

  var logLevel = Level.INFO;
  if (parsedArgs['loglevel'] != null) {
    logLevel = Level.LEVELS.firstWhere(
      (l) => l.name == parsedArgs['loglevel'].toUpperCase(),
      orElse: () => Level.INFO,
    );
  }
  Logger.root.level = logLevel;

  // Setup logging to stdout.
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  log.fine('Parsed command line arguments, and started logger');

  // Setup optional logging to file.
  final logFile = parsedArgs['logfile'];
  if (logFile != null) {
    final file = File(logFile);
    final sink = file.openWrite();
    Logger.root.onRecord.listen((record) {
      sink.write('${record.level.name}: ${record.time}: ${record.message}\n');
    });
    // Close the IOSink when the program is terminated.
    ProcessSignal.sigterm.watch().listen((_) => sink.close());
    ProcessSignal.sigint.watch().listen((_) => sink.close());
  }

  var inputFileIsDefined = parsedArgs['inputfile'] != null;
  var stdinIsDefined = !stdin.hasTerminal;
  var inputSource = inputFileIsDefined != stdinIsDefined
      ? (inputFileIsDefined ? parsedArgs['inputfile'] as String : 'stdin')
      : null; // TODO: Maybe make charlie make this more readable
  if (inputSource == null) {
    log.severe(
        'Either both or neither of file input and stdin are defined. Exiting.');
    return;
  }

  if (parsedArgs['mode'] == 'd1') {
    const String funcName = 'solveAoc15D1P1';

    if (inputSource == 'stdin') {
      var eitherResult = await solveAoc15D1P1(null, stdin);
      handleEitherResult(eitherResult, funcName);
    } else {
      var eitherResult = await solveAoc15D1P1(inputSource, null);
      handleEitherResult(eitherResult, funcName);
    }
  } else {
    log.info('Mode not defined, running default');
    log.info('Default mode activated');
  }
}

void handleEitherResult(Either<String, int> eitherResult, String funcName) {
  eitherResult.fold(
    (left) => log.severe('$funcName - $left'),
    (right) => log.info('$funcName - $right'),
  );
}
