import 'dart:io';
import 'package:args/args.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';
import 'package:logging/logging.dart';

void main(List<String> args) async {
  final parser = ArgParser()
    ..addOption('inputfile',
        abbr: 'i', help: 'Specify the path of the input file')
    ..addOption('errorlog', abbr: 'e', help: 'Specify the file to write errors')
    ..addOption('output', abbr: 'o', help: 'Specify the file to write output')
    ..addOption('mode', abbr: 'm', help: 'Define the mode')
    ..addOption('logfile', abbr: 'l', help: 'Specify the file to log messages')
    ..addOption('loglevel',
        abbr: 'v',
        help: 'Specify the logging level (default is WARNING)',
        allowed: ['ALL', 'OFF', 'FINE', 'INFO', 'WARNING', 'SEVERE', 'SHOUT']);

  final parsedArgs = parser.parse(args);

  // Set log level from command line arguments or default to WARNING
  var logLevel = Level.WARNING;
  if (parsedArgs['loglevel'] != null) {
    logLevel = Level.LEVELS.firstWhere(
        (l) => l.name == parsedArgs['loglevel'].toUpperCase(),
        orElse: () => Level.WARNING);
  }
  Logger.root.level = logLevel;

  // Log to stdout by default
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  // Log to file if option is specified
  if (parsedArgs['logfile'] != null) {
    final logFile = File(parsedArgs['logfile'] as String);
    Logger.root.onRecord.listen((record) async {
      final logLine = '${record.level.name}: ${record.time}: ${record.message}';
      await logFile.writeAsString('$logLine\n', mode: FileMode.append);
    });
  }

  final log = Logger('CLI'); // Create a logger for this class
  log.fine('Parsing command line arguments');

  StringBuffer inputDataBuffer = StringBuffer();

  if (!stdin.hasTerminal) {
    await for (var line
        in stdin.transform(Utf8Decoder()).transform(LineSplitter())) {
      inputDataBuffer.writeln(line);
    }
  } else {
    inputDataBuffer
        .write(await _fetchDataFromFile(parsedArgs['inputfile'] as String?));
  }
  // TODO: Make default_data a new and more dynamic type of list as default
  // See task_list and the builder stunts we were doing with charlie
  var inputData = inputDataBuffer.toString().isEmpty
      ? 'default_data'
      : inputDataBuffer.toString();

  var result = demoFunction(inputData, parsedArgs['mode']);

  if (result.isLeft()) {
    if (parsedArgs['errorlog'] != null) {
      await File(parsedArgs['errorlog'] as String).writeAsString(
          result.fold((leftValue) => leftValue, (rightValue) => rightValue));
    } else {
      stderr.writeln(
          result.fold((leftValue) => leftValue, (rightValue) => rightValue));
    }
  } else {
    if (parsedArgs['output'] != null) {
      await File(parsedArgs['output'] as String)
          .writeAsString(result.getOrElse(() => ''));
    } else {
      print(result.getOrElse(() => ''));
    }
  }
}

Future<String> _fetchDataFromFile(String? path) async {
  if (path == null) return 'default_data';
  return await File(path)
      .openRead()
      .transform(Utf8Decoder())
      .transform(LineSplitter())
      .first;
}

Either<String, String> demoFunction(String input, String? mode) {
  // Here you can handle different modes with different logic.
  if (mode == 'mode1') {
    return Right('Mode 1: $input');
  }

  // If no mode matches, return an error
  return Left('Invalid mode: $mode');
}
