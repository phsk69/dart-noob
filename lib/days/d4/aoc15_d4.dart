import 'package:dart_noob/util/string_stuff.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

// https://adventofcode.com/2015/day/3

String md5ToHex(String input) {
  // Compute the MD5 hash
  List<int> md5Bytes = md5.convert(utf8.encode(input)).bytes;

  // Convert bytes to hex
  return md5Bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
}

Future<BigInt> solveAoc15D4P1(String input) async {
  var baseInput = await getFileAsString(input);
  BigInt index = BigInt.zero;
  String targetPrefix = "00000";

  while (true) {
    String currentInput = baseInput + index.toString();
    String currentHex = md5ToHex(currentInput);

    if (currentHex.startsWith(targetPrefix)) {
      return index;
    }

    index = index + BigInt.one;
  }
}

Future<BigInt> solveAoc15D4P2(String input) async {
  var baseInput = await getFileAsString(input);
  BigInt index = BigInt.zero;
  String targetPrefix = "000000";

  while (true) {
    String currentInput = baseInput + index.toString();
    String currentHex = md5ToHex(currentInput);

    if (currentHex.startsWith(targetPrefix)) {
      return index;
    }

    index = index + BigInt.one;
  }
}
