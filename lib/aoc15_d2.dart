import 'dart:isolate';
import 'file_stuff.dart';

getInputByLine(String inputPath) async {
  return await FileReader(inputPath).readFileByLine();
}

getParsedList(String inputPath) async {
  return await FileReader(inputPath).parseFileListInt();
}

solveAocD2P1CoPilot(List<String> content) async {
  try {
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
  } catch (e) {
    throw 'Error: calculating stuff';
  }
}

solveAocD2P1HomeBrew(List<List<int>> content) async {
  try {
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
    }

    return totalPaper; // Moved outside of the for loop
  } catch (e) {
    throw 'Error: calculating stuff';
  }
}

List<List<T>> chunkList<T>(List<T> list, int chunkSize) {
  var chunks = <List<T>>[];
  for (var i = 0; i < list.length; i += chunkSize) {
    var end = (i + chunkSize < list.length) ? i + chunkSize : list.length;
    chunks.add(list.sublist(i, end));
  }
  return chunks;
}

int computeChunkPaper(List<List<int>> chunk) {
  var totalPaper = 0;
  for (var list in chunk) {
    var l = list[0];
    var w = list[1];
    var h = list[2];
    var side1 = l * w;
    var side2 = w * h;
    var side3 = h * l;
    var smallestSide = [side1, side2, side3].reduce((a, b) => a < b ? a : b);
    totalPaper += 2 * side1 + 2 * side2 + 2 * side3 + smallestSide;
  }
  return totalPaper;
}

void workerFunction(SendPort sendPort) {
  var rp = ReceivePort();
  sendPort.send(rp.sendPort);
  rp.listen((message) {
    var chunk = message[0] as List<List<int>>;
    var responsePort = message[1] as SendPort;
    var result = computeChunkPaper(chunk);
    responsePort.send(result);
  });
}

Future<int> solveAocD2P1HomeBrewParallel(
    List<List<int>> content, int numWorkers) async {
  int totalPaper = 0;

  // Chunk the content
  var chunks = chunkList(content, (content.length / numWorkers).ceil());

  // Create worker pool
  var workers = <Isolate>[];
  var receivePorts = <ReceivePort>[];
  var responsePorts = <SendPort>[];

  for (var i = 0; i < numWorkers; i++) {
    var rp = ReceivePort();
    receivePorts.add(rp);
    var isolate = await Isolate.spawn(workerFunction, rp.sendPort);
    workers.add(isolate);
    var sendPort = await rp.first as SendPort;
    responsePorts.add(sendPort);
  }

  // Distribute work
  var resultsFutures = <Future<int>>[];
  for (var i = 0; i < numWorkers; i++) {
    var rp = ReceivePort();
    responsePorts[i].send([chunks[i], rp.sendPort]);
    resultsFutures.add(rp.first.then((value) => value as int));
  }

  // Gather results
  var results = await Future.wait(resultsFutures);
  totalPaper = results.reduce((a, b) => a + b);

  // Clean up
  for (var isolate in workers) {
    isolate.kill();
  }
  for (var rp in receivePorts) {
    rp.close();
  }

  return totalPaper;
}
