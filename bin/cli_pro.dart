import 'dart:io';
import 'package:args/args.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';
import 'package:logging/logging.dart';

void main(List<String> args) async {
  // Configure logger
  Logger.root.level = Level.ALL;

  // Log to stdout by default
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  final log = Logger('CLI'); // Create a logger for this class

  final parser = ArgParser()
    ..addFlag('stdin', negatable: false, help: 'Read input from stdin')
    ..addOption('inputfile', help: 'Specify the path of the input file')
    ..addOption('errorlog', help: 'Specify the file to write errors')
    ..addOption('output', help: 'Specify the file to write output')
    ..addOption('mode', abbr: 'm', help: 'Define the mode')
    ..addOption('logfile', help: 'Specify the file to log messages');

  final parsedArgs = parser.parse(args);

  // Log to file if option is specified
  if (parsedArgs['logfile'] != null) {
    final logFile = File(parsedArgs['logfile'] as String);
    Logger.root.onRecord.listen((record) async {
      final logLine = '${record.level.name}: ${record.time}: ${record.message}';
      await logFile.writeAsString('$logLine\n', mode: FileMode.append);
    });
  }

  log.fine('Parsing command line arguments');

  var inputData = !stdin.hasTerminal
      ? (stdin.readLineSync() ?? 'default_data')
      : await _fetchDataFromFile(parsedArgs['inputfile'] as String?);

  var result = demoFunction(inputData, parsedArgs['mode']);

  if (result.isLeft()) {
    if (parsedArgs['errorlog'] != null) {
      await File(parsedArgs['errorlog'] as String)
          .writeAsString(result.fold((l) => l, (r) => r));
    } else {
      stderr.writeln(result.fold((l) => l, (r) => r));
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
