import 'dart:io';
import 'package:test/test.dart';
import 'package:dart_noob/util/sink_manager.dart';

void main() {
  group('SinkManager', () {
    late SinkManager sinkManager;
    late Directory tempDir;

    setUp(() {
      sinkManager = SinkManager();
      tempDir = Directory.systemTemp.createTempSync();
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('initializeLogSink initializes the log sink correctly', () async {
      final logFilePath = '${tempDir.path}/log.txt';
      sinkManager.initializeLogSink(logFilePath);
      final logFile = File(logFilePath);

      sinkManager.logSink?.writeln('Test log message');
      await sinkManager.logSink?.close();

      expect(logFile.existsSync(), true);
      expect(logFile.readAsStringSync(),
          'Test log message\n'); // Ensure the message matches exactly
    });

    test('initializeOutputSink initializes the output sink correctly',
        () async {
      final outputFilePath = '${tempDir.path}/output.txt';
      sinkManager.initializeOutputSink(outputFilePath);
      final outputFile = File(outputFilePath);

      sinkManager.outputSink.writeln('Test output message');
      // The next line may not be necessary since it's a standard sink, but it's good to be explicit.
      await sinkManager.outputSink.close();

      expect(outputFile.existsSync(), true);
      expect(outputFile.readAsStringSync(), 'Test output message\n');
    });
  });
}
