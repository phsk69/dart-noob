import 'package:test/test.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'dart:io';

void main() {
  group('FileReader', () {
    test('reads content from valid file', () async {
      // Create a temporary file with content
      var tempFile = await File('temp_test.txt').writeAsString('Test content');

      var reader = FileReader(tempFile.path);
      var contentObj = await reader.splitFileStringToList();

      expect(contentObj.join(), 'Test content');

      await tempFile.delete(); // Clean up
    });
    test('reads content line by line from valid file', () async {
      // Create a temporary file with multiple lines
      var tempFile = await File('temp_test_lines.txt')
          .writeAsString('Line 1\nLine 2\nLine 3');

      var reader = FileReader(tempFile.path);
      var lines = await reader.readFileByLine();

      // Check that the file is split correctly into lines
      expect(lines, ['Line 1', 'Line 2', 'Line 3']);

      await tempFile.delete(); // Clean up
    });
    test('throws an error for an invalid file path when reading by line',
        () async {
      var reader = FileReader('non_existent_file.txt');

      // Expect that calling readFileByLine on a non-existent file will throw an error
      expect(reader.readFileByLine(), throwsA(isA<String>()));
    });
    test('parses content into a list of list of integers', () async {
      // Create a temporary file with mock data for parsing
      var tempFile =
          await File('temp_test_dimensions.txt').writeAsString('2x3x4\n1x1x10');

      var reader = FileReader(tempFile.path);
      var parsedList = await reader.parseFileListInt();

      // Check the parsed content
      expect(parsedList, [
        [2, 3, 4],
        [1, 1, 10]
      ]);

      await tempFile.delete(); // Clean up
    });
    test('Creates a string buffer from an input file', () async {
      // Create a temporary file with mock data for parsing
      var tempFile =
          await File('temp_test_dimensions.txt').writeAsString('2x3x4\n1x1x10');

      var reader = FileReader(tempFile.path);
      var parsedList = await reader.parseFileListInt();

      // Check the parsed content
      expect(parsedList, [
        [2, 3, 4],
        [1, 1, 10]
      ]);

      await tempFile.delete(); // Clean up
    });
  });
  group('streamLinesFromFile', () {
    test('reads lines from a valid file', () async {
      var tempFile = await File('temp_test_stream.txt')
          .writeAsString('Line 1\nLine 2\nLine 3');

      var lines = [];

      await for (var line in streamLinesFromFile(tempFile.path)) {
        lines.add(line);
      }

      expect(lines, ['Line 1', 'Line 2', 'Line 3']);

      await tempFile.delete(); // Clean up
    });

    test('throws an error for an invalid file path', () async {
      var stream = streamLinesFromFile('non_existent_file.txt');

      // Since the function uses streams, the error will be thrown when you listen to the stream
      expect(stream.toList(), throwsA(isA<FileSystemException>()));
    });
  });
  group('Helper Functions', () {
    test('getInputByLine returns content line by line', () async {
      var tempFile = await File('temp_helper_test.txt')
          .writeAsString('Helper Line 1\nHelper Line 2');

      var lines = await getInputByLine(tempFile.path);

      expect(lines, ['Helper Line 1', 'Helper Line 2']);

      await tempFile.delete();
    });

    test('getParsedList returns parsed list of integers', () async {
      var tempFile = await File('temp_helper_dimensions.txt')
          .writeAsString('3x4x5\n2x2x2');

      var parsedList = await getParsedList(tempFile.path);

      expect(parsedList, [
        [3, 4, 5],
        [2, 2, 2]
      ]);

      await tempFile.delete();
    });

    test('getInputString returns a list of characters from file', () async {
      var tempFile = await File('temp_helper_char.txt').writeAsString('abcd');

      var chars = await getInputString(tempFile.path);

      expect(chars, ['a', 'b', 'c', 'd']);

      await tempFile.delete();
    });

    test('getFileAsString returns file content as string', () async {
      var tempFile =
          await File('temp_helper_string.txt').writeAsString('Hello Helper!');

      var content = await getFileAsString(tempFile.path);

      expect(content, 'Hello Helper!');

      await tempFile.delete();
    });

    test('getStringBuffer returns StringBuffer from input file', () async {
      var tempFile =
          await File('temp_helper_buffer.txt').writeAsString('Buffer Test');

      var buffer = await getStringBuffer(tempFile.path);

      expect(
          buffer.toString(), 'Buffer Test\n'); // Buffer writes with a newline

      await tempFile.delete();
    });

    test('getInputContent returns Left error for all null inputs', () async {
      var result = await getInputContent(null, null, null);
      expect(result.isLeft(), true);
      expect(result.swap().getOrElse(() => ''),
          'All input sources cannot be null.');
    });

    test('getInputContent returns content string for valid file path',
        () async {
      var tempFile = await File('temp_helper_input_content.txt')
          .writeAsString('Input Content Test');

      var result = await getInputContent(tempFile.path, null, null);

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Input Content Test');

      await tempFile.delete();
    });

    test('getInputContent returns content string for valid byte stream',
        () async {
      var tempFile = await File('temp_helper_input_stream.txt')
          .writeAsString('Stream Content Test');

      Stream<List<int>> fileStream = tempFile.openRead();
      var result = await getInputContent(null, fileStream, null);

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Stream Content Test\n');

      await tempFile.delete();
    });

    test('getInputContent returns content string for valid StringBuffer',
        () async {
      StringBuffer buffer = StringBuffer();
      buffer.write('Buffer Content Test');

      var result = await getInputContent(null, null, buffer);

      expect(result.isRight(), true);
      expect(result.getOrElse(() => ''), 'Buffer Content Test');
    });

    test(
        'getInputContent returns error for both input path and stream provided',
        () async {
      var tempFile = await File('temp_helper_both_input.txt')
          .writeAsString('Both Content Test');
      Stream<List<int>> fileStream = tempFile.openRead();

      var result = await getInputContent(tempFile.path, fileStream, null);

      expect(result.isLeft(), true);
      expect(result.swap().getOrElse(() => ''),
          'Only one source of input is allowed.');

      await tempFile.delete();
    });

    test('getInputContent returns error for both stream and buffer provided',
        () async {
      StringBuffer buffer = StringBuffer();
      buffer.write('Buffer Content Test with Stream');
      Stream<List<int>> fakeStream = Stream.fromIterable([
        [1],
        [2],
        [3]
      ]);

      var result = await getInputContent(null, fakeStream, buffer);

      expect(result.isLeft(), true);
      expect(result.swap().getOrElse(() => ''),
          'Only one source of input is allowed.');
    });

    test(
        'getInputContent returns error for both input path and buffer provided',
        () async {
      StringBuffer buffer = StringBuffer();
      buffer.write('Buffer Content Test with Input');
      var tempFile = await File('temp_helper_both_input_buffer.txt')
          .writeAsString('Both Content Test with Buffer');

      var result = await getInputContent(tempFile.path, null, buffer);

      expect(result.isLeft(), true);
      expect(result.swap().getOrElse(() => ''),
          'Only one source of input is allowed.');

      await tempFile.delete();
    });
  });
}
