import 'reader.dart';

void main() async {
  final boards = await boardsAfterBingoSession();
  final firstBingo = boards.first;
  final lastBingo = boards.last;

  final part1 = firstBingo.sumOfUnmarked() * firstBingo.bingoDraw!;
  assert(part1 == 32844);
  final part2 = lastBingo.sumOfUnmarked() * lastBingo.bingoDraw!;
  assert(part2 == 4920);
}

Future<List<Board>> boardsAfterBingoSession() async {
  final input = await readFile('04', '\r\n\r\n');
  final draws = input.first.split(',').map((e) => int.parse(e));
  final boards = input.skip(1).map((e) => Board.fromInput(e)).toList();

  var bingoCount = 0;

  for (var draw in draws) {
    for (var board in boards) {
      if (!board.isBingo) {
        board.numbers.expand((e) => e).forEach(
          (number) {
            if (number.value == draw) {
              number.setMarked();
            }
          },
        );
      }

      board.checkIfBingo(
        draw,
        bingoCount,
        () => bingoCount++,
      );
    }

    if (boards.every((e) => e.isBingo)) {
      boards.sort((a, b) => a.bingoPosition!.compareTo(b.bingoPosition!));
      break;
    }
  }

  return boards;
}

class Board {
  final List<List<Number>> numbers;
  int? bingoPosition;
  int? bingoDraw;

  Board(this.numbers);

  factory Board.fromInput(String input) {
    final numbersFromInput = input
        .replaceAll('\r\n', ' ')
        .split(' ')
        .where((e) => e.isNotEmpty)
        .map((e) => int.parse(e))
        .toList();

    var iterator = 0;
    final generatedNumbers =
        List.generate(5, (_) => List.generate(5, (_) => Number()));

    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        generatedNumbers[i][j].setNumber(numbersFromInput[iterator++]);
      }
    }

    return Board(generatedNumbers);
  }

  bool get isBingo {
    final winScenarios = [];

    for (var i = 0; i < 5; i++) {
      final x = [];
      final y = [];
      for (var j = 0; j < 5; j++) {
        x.add(numbers[i][j].marked);
        y.add(numbers[j][i].marked);
      }
      winScenarios.addAll([x, y]);
    }

    return winScenarios
        .any((element) => element.every((element) => element == true));
  }

  int sumOfUnmarked() {
    return numbers
        .expand((e) => e)
        .where((e) => !e.marked)
        .fold(0, (int previousValue, Number e) => previousValue + e.value!);
  }

  void checkIfBingo(
    int draw,
    int bingoCount,
    Function atBingo,
  ) {
    if (isBingo && bingoPosition == null) {
      bingoPosition = bingoCount++;
      bingoDraw = draw;
      atBingo();
    }
  }
}

class Number {
  int? value;
  bool marked = false;

  void setNumber(int num) {
    value = num;
  }

  void setMarked() {
    marked = true;
  }
}
