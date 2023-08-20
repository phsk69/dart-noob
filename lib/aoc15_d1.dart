import 'file_stuff.dart';

solveAocD1P1(List<String> arguments) async {
  String filePath = arguments[0];

  FileReader reader = FileReader(filePath);

  var content = await reader.readFile();

  var i = 0;

  for (var element in content) {
    switch (element) {
      case '(':
        i++;
        break;
      case ')':
        i--;
        break;
    }
  }
  return i;
}

solveAocD1P2(List<String> arguments) async {
  String filePath = arguments[0];

  FileReader reader = FileReader(filePath);

  var content = await reader.readFile();

  var floor = 0;
  const int basement = -1;
  var firstBasementPos = 0;

  for (var idx = 0; idx < content.length; idx++) {
    var element = content[idx];
    switch (element) {
      case '(':
        floor++;
        break;
      case ')':
        floor--;
        if (floor == basement) {
          firstBasementPos = idx + 1;
          return firstBasementPos;
        }
        break;
    }
  }
}
