import 'package:dartz/dartz.dart';

// Function types - String return
typedef StringTaskReturnString = Future<Either<String, String>> Function(
    {String? input, Stream<List<int>>? stdinStream});
typedef StringAndIntTaskReturnString = Future<Either<String, String>>
    Function(int count, {String? input, Stream<List<int>>? stdinStream});

// Function types - Int return
typedef StringTaskReturnInt = Future<Either<String, int>> Function(
    {String? input, Stream<List<int>>? stdinStream});
typedef StringAndIntTaskReturnInt = Future<Either<String, int>>
    Function(int count, {String? input, Stream<List<int>>? stdinStream});
