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

      expect(contentObj.characters.join(), 'Test content');
      expect(contentObj.length, 12); // "Test content" has 12 characters

      await tempFile.delete(); // Clean up
    });

    test('throws an error for an invalid file', () async {
      var reader = FileReader('non_existent_file.txt');
      expect(() async {
        await reader.readFile();
      }, throwsA(isA<String>()));
    });
  });
}
