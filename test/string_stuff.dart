import 'package:test/test.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'dart:io';

void main() {
  group('FileReader', () {
    test('reads content from valid file', () async {
      var tempFile = await File('temp_test.txt').writeAsString('Test content');

      var reader = FileReader(tempFile.path);
      var contentObj = await reader.splitFileStringToList();

      expect(contentObj.join(), 'Test content');

      await tempFile.delete(); // Clean up
    });

    test('reads content line by line from valid file', () async {
      var tempFile = await File('temp_test_lines.txt')
          .writeAsString('Line 1\nLine 2\nLine 3');

      var reader = FileReader(tempFile.path);
      var lines = await reader.readFileByLine();

      expect(lines, ['Line 1', 'Line 2', 'Line 3']);

      await tempFile.delete(); // Clean up
    });

    test('parses content into a list of list of integers', () async {
      var tempFile =
          await File('temp_test_dimensions.txt').writeAsString('2x3x4\n1x1x10');

      var reader = FileReader(tempFile.path);
      var parsedList = await reader.parseFileListInt();

      expect(parsedList, [
        [2, 3, 4],
        [1, 1, 10]
      ]);

      await tempFile.delete(); // Clean up
    });

    test('reads file content as a string', () async {
      var tempFile = await File('temp_test_string_content.txt')
          .writeAsString('Hello FileReader!');

      var reader = FileReader(tempFile.path);
      var content = await reader.readStringFromFile();

      expect(content, 'Hello FileReader!');

      await tempFile.delete(); // Clean up
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

    test('getStringBuffer returns content in a StringBuffer', () async {
      var tempFile = await File('temp_helper_string_buffer.txt')
          .writeAsString('Hello StringBuffer\nThis is a new line');

      var buffer = await getStringBuffer(tempFile.path);

      expect(buffer.toString(),
          'Hello StringBuffer\nThis is a new line\n'); // Remember that `writeln` adds a newline.

      await tempFile.delete();
    });

    test('streamLinesFromFile streams lines from a file', () async {
      var tempFile = await File('temp_helper_stream_lines.txt')
          .writeAsString('Stream Line 1\nStream Line 2');

      List<String> lines = [];
      await for (var line in streamLinesFromFile(tempFile.path)) {
        lines.add(line);
      }

      expect(lines, ['Stream Line 1', 'Stream Line 2']);

      await tempFile.delete();
    });

    test('getInputContent returns content from a StringBuffer', () {
      StringBuffer buffer = StringBuffer('This is a test content');
      var content = getInputContent(buffer);

      expect(content.getOrElse(() => ''), 'This is a test content');
    });

    test('getInputContent returns error for null StringBuffer', () {
      var content = getInputContent(null);

      expect(content.isLeft(), true);
      expect(content.fold((l) => l, (r) => r), 'InputBuffer cannot be null.');
    });
  });
}
