import 'package:dart_noob/file_stuff.dart';

solveAocD2P1CoPilot(List<String> arguments) async {
  String filePath = arguments[0];

  FileReader reader = FileReader(filePath);

  var content = await reader.readFileByLine();

  var totalPaper = 0;

  for (var line in content) {
    var dimensions = line.split('x');
    var l = int.parse(dimensions[0]);
    var w = int.parse(dimensions[1]);
    var h = int.parse(dimensions[2]);

    var side1 = l * w;
    var side2 = w * h;
    var side3 = h * l;

    var smallestSide = side1;
    if (side2 < smallestSide) {
      smallestSide = side2;
    }
    if (side3 < smallestSide) {
      smallestSide = side3;
    }

    var paper = 2 * side1 + 2 * side2 + 2 * side3 + smallestSide;

    totalPaper += paper;
  }

  return totalPaper;
}

solveAocD2P1HomeBrew(List<String> arguments) async {
  String filePath = arguments[0];

  FileReader reader = FileReader(filePath);

  try {
    var content = await reader.parseFileListInt();
    var totalPaper = 0;

    for (var list in content) {
      var l = list[0];
      var w = list[1];
      var h = list[2];

      var side1 = l * w;
      var side2 = w * h;
      var side3 = h * l;

      var smallestSide = side1;
      if (side2 < smallestSide) {
        smallestSide = side2;
      }
      if (side3 < smallestSide) {
        smallestSide = side3;
      }

      var paper = 2 * side1 + 2 * side2 + 2 * side3 + smallestSide;

      totalPaper += paper;

      return totalPaper;
    }
  } catch (e) {
    throw 'Error: calculating stuff';
  }
}
