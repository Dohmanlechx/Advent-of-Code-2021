import 'reader.dart';

void main() async {
  part01();
  part02();
}

Future<void> part01() async {
  final input = await readFile('02');
  var horizontal = 0;
  var depth = 0;

  for (final command in input) {
    final direction = command.split(' ').first;
    final units = int.parse(command.split(' ').last);

    switch (direction) {
      case 'forward':
        horizontal += units;
        break;
      case 'down':
        depth += units;
        break;
      case 'up':
        depth -= units;
        break;
    }
  }

  final res = horizontal * depth;

  assert(res == 2073315);
}

Future<void> part02() async {
  final input = await readFile('02');
  var horizontal = 0;
  var depth = 0;
  var aim = 0;

  for (final command in input) {
    final direction = command.split(' ').first;
    final units = int.parse(command.split(' ').last);

    switch (direction) {
      case 'forward':
        horizontal += units;
        depth += (aim * units);
        break;
      case 'down':
        aim += units;
        break;
      case 'up':
        aim -= units;
        break;
    }
  }

  final res = horizontal * depth;

  assert(res == 1840311528);
}
