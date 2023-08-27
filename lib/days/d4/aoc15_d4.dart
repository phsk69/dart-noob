import 'package:dart_noob/util/file_stuff.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

String md5ToHex(String input) {
  // Compute the MD5 hash
  List<int> md5Bytes = md5.convert(utf8.encode(input)).bytes;

  // Convert bytes to hex
  return md5Bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
}

Future<BigInt> solveAoc15D4P1(String input) async {
  var baseInput = await getFileAsString(input);
  BigInt index = BigInt.zero; // Start from zero
  String targetPrefix =
      "00000"; // This is the prefix we're looking for in the hash.

  while (true) {
    String currentInput = baseInput + index.toString();
    String currentHex = md5ToHex(currentInput);

    if (currentHex.startsWith(targetPrefix)) {
      return index;
    }

    index = index + BigInt.one; // Increment the index.
  }
}

Future<BigInt> solveAoc15D4P2(String input) async {
  var baseInput = await getFileAsString(input);
  BigInt index = BigInt.zero; // Start from zero
  String targetPrefix =
      "000000"; // This is the prefix we're looking for in the hash.

  while (true) {
    String currentInput = baseInput + index.toString();
    String currentHex = md5ToHex(currentInput);

    if (currentHex.startsWith(targetPrefix)) {
      return index;
    }

    index = index + BigInt.one; // Increment the index.
  }
}
