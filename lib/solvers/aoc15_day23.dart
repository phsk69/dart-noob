import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:dart_noob/factories/solver_factory.dart';

// https://adventofcode.com/2015/day/23

List<String> parseD23Input(String d22Input) {
  return d22Input.toString().split('\n');
}

class RegisterMachine {
  final Map<String, int> registers;
  final List<String> instructions;
  final Logger? logger;

  RegisterMachine(this.registers, this.instructions, this.logger);

  void execute() {
    int instructionPointer = 0;

    while (instructionPointer < instructions.length) {
      var instruction = instructions[instructionPointer];
      var parts = instruction.split(' ');
      var command = parts[0];

      String register;
      int oldRegisterValue;

      int offset = 1; // Default to next instruction

      switch (command) {
        case 'hlf':
          register = parts[1];
          oldRegisterValue = registers[register]!;
          registers[register] = oldRegisterValue ~/ 2;
          logger?.info(
              'Halving register $register: $oldRegisterValue -> ${registers[register]}');
          break;
        case 'tpl':
          register = parts[1];
          oldRegisterValue = registers[register]!;
          registers[register] = oldRegisterValue * 3;
          logger?.info(
              'Tripling register $register: $oldRegisterValue -> ${registers[register]}');
          break;
        case 'inc':
          register = parts[1];
          oldRegisterValue = registers[register]!;
          registers[register] = oldRegisterValue + 1;
          logger?.info(
              'Incrementing register $register: $oldRegisterValue -> ${registers[register]}');
          break;
        case 'jmp':
          offset = int.parse(parts[1]);
          logger?.info('Jumping by offset: $offset');
          break;
        case 'jie':
          register = parts[1].replaceAll(',', '');
          if (registers[register]! % 2 == 0) {
            offset = int.parse(parts[2]);
            logger?.info(
                'Jump-if-even on register $register: Jumping by offset: $offset');
          } else {
            logger?.info(
                'Jump-if-even on register $register: Condition not met, moving to next instruction');
          }
          break;
        case 'jio':
          register = parts[1].replaceAll(',', '');
          if (registers[register] == 1) {
            offset = int.parse(parts[2]);
            logger?.info(
                'Jump-if-one on register $register: Jumping by offset: $offset');
          } else {
            logger?.info(
                'Jump-if-one on register $register: Condition not met, moving to next instruction');
          }
          break;
      }

      instructionPointer += offset;
      logger?.info('New instructionPointer position: $instructionPointer');
    }
  }
}

class Day23P1Solver extends AoCSolver {
  final String? filePath;
  final Logger? logger;

  Day23P1Solver(StringBuffer? input, this.filePath, this.logger) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString().trim() ?? filePath!.trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }

      List<String> instructionList = parseD23Input(inputData);

      final Map<String, int> registers = {'a': 0, 'b': 0};

      RegisterMachine(registers, instructionList, logger).execute();

      return Right('Day23P1Solver: ${registers['b']}');
    } catch (e) {
      var errorMsg = 'Day23P1Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}

class Day23P2Solver extends AoCSolver {
  final String? filePath;
  final Logger? logger;

  Day23P2Solver(StringBuffer? input, this.filePath, this.logger) : super(input);

  @override
  Either<String, String> solve() {
    try {
      var inputData = input?.toString().trim() ?? filePath!.trim();
      if (inputData.isEmpty) {
        return Left('Input is empty.');
      }
      List<String> instructionList = parseD23Input(inputData);

      final Map<String, int> registers = {'a': 1, 'b': 0};

      RegisterMachine(registers, instructionList, logger).execute();

      return Right('Day23P2Solver: ${registers['b']}');
    } catch (e) {
      var errorMsg = 'Day23P2Solver: ${e.toString()}';
      return Left(errorMsg);
    }
  }
}
