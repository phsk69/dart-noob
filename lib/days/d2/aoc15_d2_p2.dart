import 'package:dart_noob/util/string_stuff.dart';

// https://adventofcode.com/2015/day/2

Future<int> solveAoc15D2P2ListOfLists(String inputPath) async {
  try {
    var listOfListsContent = await getParsedList(inputPath);
    var totalRibbon = 0;
    for (var box in listOfListsContent) {
      box.sort();

      var ribbonSum = 2 * (box[0] + box[1]);
      var bowSum = box[0] * box[1] * box[2];

      totalRibbon += ribbonSum + bowSum;
    }
    return totalRibbon;
  } catch (e) {
    throw 'solveAoc15D2P2ListOfLists: $e';
  }
}
