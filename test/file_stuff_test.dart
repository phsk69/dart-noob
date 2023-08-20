import 'package:test/test.dart';
import 'package:dart_noob/file_stuff.dart';
import 'dart:io';

void main() {
  group('FileReader', () {
    test('reads content from valid file', () async {
      // Create a temporary file with content
      var tempFile = await File('temp_test.txt').writeAsString('Test content');

      var reader = FileReader(tempFile.path);
      var contentObj = await reader.readFile();

      expect(contentObj.join(), 'Test content');
      expect(contentObj.length, 12); // "Test content" has 12 characters

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
  });
}
