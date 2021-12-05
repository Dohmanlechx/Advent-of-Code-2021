import 'reader.dart';

void main() async {
  await part01();
  await part02();
}

Future<void> part01() async {
  final input = await readFile('01');
  final depths = input.map((e) => int.parse(e)).toList();
  var increments = 0;

  for (var i = 1; i < input.length; i++) {
    if (depths[i] > depths[i - 1]) {
      increments++;
    }
  }

  assert(increments == 1665);
}

Future<void> part02() async {
  final input = await readFile('01');
  final depths = input.map((e) => int.parse(e)).toList();
  var increments = 0;

  for (var i = 0; i < input.length - 3; i++) {
    final sum = depths[i] + depths[i + 1] + depths[i + 2];
    final sum2 = depths[i + 1] + depths[i + 2] + depths[i + 3];
    if (sum2 > sum) {
      increments++;
    }
  }

  assert(increments == 1702);
}
