import 'package:test/test.dart';
import 'package:dart_noob/dart_noob.dart';
import 'dart:io';

void main() {
  group('asyncFile', () {
    test('reads content from valid file', () async {
      // Create a temporary file with content
      var tempFile = await File('temp_test.txt').writeAsString('Test content');

      var content = await asyncFile(tempFile.path);

      expect(content, 'Test content');

      await tempFile.delete(); // Clean up
    });

    test('throws an error for an invalid file', () async {
      expect(() async {
        await asyncFile('non_existent_file.txt');
      }, throwsA(isA<String>()));
    });
  });
}
