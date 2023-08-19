import 'package:dart_noob/file_stuff.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('Please provide a file path.');
    return;
  }

  String filePath = arguments[0];

  FileReader reader = FileReader(filePath);

  FileContent content = await reader.readFile();

  // Print the entire content
  print(content.characters.join());

  // Print the length
  print(content.length);
}
