import 'dart:io';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:dart_noob/util/logger_manager.dart';
import 'package:dart_noob/util/sink_manager.dart';
import 'package:dart_noob/util/output_manager.dart';

class MockOutputManager extends Mock implements OutputManager {}

void main() {
  group('LoggerManager', () {
    late SinkManager realSinkManager;
    late MockOutputManager mockOutputManager;
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync();
      realSinkManager = SinkManager();
      mockOutputManager = MockOutputManager();
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('Logger sets up correctly with a log file', () async {
      final loggerName = 'TestLogger';
      final logFilePath = '${tempDir.path}/logfile.log';

      final loggerManager = LoggerManager(
        logFile: logFilePath,
        name: loggerName,
        sinkManager: realSinkManager,
        outputManager: mockOutputManager,
      );

      // Check that the logger was setup with the correct name
      expect(loggerManager.log?.name, loggerName);

      // Check that the log file was created
      final logFile = File(logFilePath);
      expect(await logFile.exists(), true);

      // Verify that the outputManager wrote the log path message
      verify(mockOutputManager.writeOutput('Log: $logFilePath')).called(1);
    });

    test('Logger handles log records correctly', () async {
      final loggerName = 'TestLogger';
      final logFilePath = '${tempDir.path}/logfile.log';

      final loggerManager = LoggerManager(
        logFile: logFilePath,
        name: loggerName,
        sinkManager: realSinkManager,
        outputManager: mockOutputManager,
      );

      final logMessage = 'Test log message';
      final expectedLogPattern =
          RegExp(r'\d+-\d+-\d+T\d+:\d+:\d+\.\d+Z - INFO - Test log message');

      loggerManager.log?.info(logMessage);

      // Allow some time for the log message to be written
      await Future.delayed(Duration(milliseconds: 200));

      final logFileContent = File(logFilePath).readAsStringSync();

      expect(expectedLogPattern.hasMatch(logFileContent), true);
    });
  });
}
