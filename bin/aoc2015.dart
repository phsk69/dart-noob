import 'dart:io';
import 'dart:convert';
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
        allowed: ['ALL', 'OFF', 'FINE', 'INFO', 'WARNING', 'SEVERE', 'SHOUT']);

  final parsedArgs = parser.parse(args);

  var logLevel = Level.WARNING;
  if (parsedArgs['loglevel'] != null) {
    logLevel = Level.LEVELS.firstWhere(
      (l) => l.name == parsedArgs['loglevel'].toUpperCase(),
      orElse: () => Level.WARNING,
    );
  }
  Logger.root.level = logLevel;

  log.fine('Parsing command line arguments');

  var inputSource = parsedArgs['inputfile'] as String? ??
      (stdin.hasTerminal ? null : 'stdin');

  if (inputSource == 'stdin') {
    var eitherResult = await solveAoc15D1P1(null, stdin);
    handleEitherResult(eitherResult);
  } else {
    var eitherResult = await solveAoc15D1P1(inputSource, null);
    handleEitherResult(eitherResult);
  }
}

void handleEitherResult(Either<String, int> eitherResult) {
  eitherResult.fold(
    (left) => print('Error: $left'),
    (right) => print('Success: $right'),
  );
}
