import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:dart_noob/util/string_stuff.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/4

class Day4P1Solver extends AoCSolver {
  final String? filePath;

  Day4P1Solver(StringBuffer? input, [this.filePath]) : super(input);

  static String md5ToHex(String input) {
    List<int> md5Bytes = md5.convert(utf8.encode(input)).bytes;
    return md5Bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
  }

  @override
  Either<String, String> solve() {
    try {
      // Trim added on the buffer as the entry makes a buffer with newline
      var baseInput = (input?.toString() ?? getStringSync(filePath!)).trim();

      if (baseInput.isEmpty) {
        return Left('Input is empty');
      }

      BigInt index = BigInt.zero;
      String targetPrefix = "00000";

      while (true) {
        String currentInput = baseInput + index.toString();
        String currentHex = md5ToHex(currentInput);

        if (currentHex.startsWith(targetPrefix)) {
          return Right('solveAoc15D4P1: $index');
        }

        index = index + BigInt.one;
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}

class Day4P2Solver extends AoCSolver {
  final String? filePath;

  Day4P2Solver(StringBuffer? input, [this.filePath]) : super(input);

  static String md5ToHex(String input) {
    List<int> md5Bytes = md5.convert(utf8.encode(input)).bytes;
    return md5Bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
  }

  @override
  Either<String, String> solve() {
    try {
      // Trim added on the buffer as the entry makes a buffer with newline
      var baseInput = (input?.toString() ?? getStringSync(filePath!)).trim();

      if (baseInput.isEmpty) {
        return Left('Input is empty');
      }

      BigInt index = BigInt.zero;
      String targetPrefix = "000000";

      while (true) {
        String currentInput = baseInput + index.toString();
        String currentHex = md5ToHex(currentInput);

        if (currentHex.startsWith(targetPrefix)) {
          return Right('solveAoc15D4P2: $index');
        }

        index = index + BigInt.one;
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
