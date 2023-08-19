import 'package:dart_noob/dart_noob.dart' as dart_noob;

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('Please provide a file path.');
    return;
  }

  String filePath = arguments[0];

  try {
    String content = await dart_noob.asyncFile(filePath);
    if (content.isNotEmpty) {
      print(content);
    } else {
      print('File is empty.');
    }
  } catch (e) {
    print('Error printing file - $e');
  }
}