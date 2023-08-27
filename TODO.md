# dart_noob

## Doing

- When complete identify meaningful performance test, or demo relevant diffrences in appproaches.
- Move the each solution into its own file for better readability
  - Unless its a class with minimal helpers

### Ideas

### Return errors by value

```dart
// Simple demo setup
import 'package:dartz/dartz.dart';

Either<String, int> divide(int dividend, int divisor) {
  if (divisor == 0) {
    return Left("Cannot divide by zero");
  } else {
    return Right(dividend ~/ divisor);
  }
}

final result = divide(10, 2);
result.fold(
  (l) => print('Error: $l'), 
  (r) => print('Result: $r')
);
```

```dart
// For async shit
class Result<T> {
  final T? value;
  final Object? error;

  bool get isSuccess => error == null;
  bool get isError => !isSuccess;

  Result.success(this.value) : error = null;
  Result.error(this.error) : value = null;
}

Future<Result<String>> fetchSomething() async {
  try {
    String result = await someAsyncOperation();
    return Result.success(result);
  } catch (e) {
    return Result.error(e);
  }
}
var result = await fetchSomething();
if (result.isSuccess) {
  print(result.value);
} else {
  print('Error occurred: ${result.error}');
}
```
