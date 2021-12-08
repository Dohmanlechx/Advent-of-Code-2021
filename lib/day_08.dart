import 'package:Advent_of_Code_2021/reader.dart';

void main() async {
  final p1 = await part01();
  final p2 = await part02();
  assert(p1 == 416);
  assert(p2 == 1043697);
}

Future<int> part01() async {
  final input = await readFile('08');
  final uniques = <int, int>{2: 1, 4: 4, 3: 7, 7: 8};
  final res = input
      .map((e) => e.split(' | ').last)
      .join()
      .replaceAll('\r', ' ')
      .split(' ')
      .where((e) => uniques[e.length] != null)
      .length;
  return res;
}

Future<int> part02() async {
  final input = await readFile('08');
  final decodedOutputValues = <int>[];

  for (var entry in input.map((e) => e.replaceAll('\r', ' '))) {
    final decodedValues = {for (var i = 0; i < 10; i++) i: <String>[]};

    final blocks = entry.replaceAll(' | ', ' ').split(' ');
    for (var block in blocks) {
      switch (block.length) {
        case 2:
          decodedValues.addIfEmpty(1, block);
          break;
        case 4:
          decodedValues.addIfEmpty(4, block);
          break;
        case 3:
          decodedValues.addIfEmpty(7, block);
          break;
        case 7:
          decodedValues.addIfEmpty(8, block);
          break;
      }
    }

    for (var block in blocks.where((e) => e.length == 6)) {
      if (decodedValues[4]!.every((e) => block.contains(e)) &&
          decodedValues[7]!.every((e) => block.contains(e))) {
        decodedValues.addIfEmpty(9, block);
      } else if (decodedValues[7]!.every((e) => block.contains(e))) {
        decodedValues.addIfEmpty(0, block);
      } else {
        decodedValues.addIfEmpty(6, block);
      }
    }

    for (var block in blocks.where((e) => e.length == 5)) {
      if (decodedValues[1]!.every((e) => block.contains(e))) {
        decodedValues.addIfEmpty(3, block);
      } else if (decodedValues[9]!
          .every((e) => [decodedValues[1]!, block].join('').contains(e))) {
        decodedValues.addIfEmpty(5, block);
      } else {
        decodedValues.addIfEmpty(2, block);
      }
    }

    final encodedOutputValuesOfEntry = entry.split(' | ').last.split(' ');
    final decodedOutputValue = <String>[];

    for (var digit in encodedOutputValuesOfEntry) {
      for (var i = 0; i < 10; i++) {
        if (digit.split('').equalsTo(decodedValues[i]!)) {
          decodedOutputValue.add(i.toString());
          break;
        }
      }
    }
    decodedOutputValues.add(
      int.parse(decodedOutputValue.join()),
    );
  }

  return decodedOutputValues.reduce((a, b) => a + b);
}

extension on List {
  bool equalsTo(List other) {
    return (length == other.length) && every((item) => other.contains(item));
  }
}

extension on Map<int, List<String>> {
  void addIfEmpty(int key, String value) {
    if (this[key]!.isEmpty) {
      this[key] = value.split('');
    }
  }
}
