import 'package:dart_noob/util/file_stuff.dart';

// https://adventofcode.com/2015

solveAocD2P2ListOfLists(String inputPath) async {
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
    throw 'solveAocD2P2ListOfLists: $e';
  }
}


