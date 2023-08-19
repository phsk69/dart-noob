import 'dart:io';

Future<String> asyncFile(String filepath) async {
  try {
    String contents = await File(filepath).readAsString();
    if (contents.isNotEmpty) {
      return contents;
    }
    return ''; // or return an appropriate default value or error message
  } catch (e) {
    throw 'Error reading the file in asyncFile: $e';
  }
}
