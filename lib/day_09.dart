import 'package:Advent_of_Code_2021/reader.dart';

void main() async {
  final p1 = await part01();
  final p2 = await part02();
  assert(p1 == 496);
  // assert(p2 == 1043697);
}

Future<int> part01() async {
  final input = await readFile('09');
  final heightMap = List.generate(input.length, (index) => <int>[]);

  for (var i = 0; i < input.length; i++) {
    for (var c in input[i].replaceAll('\r', '').split('')) {
      heightMap[i].add(int.parse(c));
    }
  }

  final lowestPoints = <int>[];

  for (var i = 0; i < heightMap.length; i++) {
    for (var j = 0; j < heightMap[0].length; j++) {
      var left = 10;
      var up = 10;
      var right = 10;
      var down = 10;

      try {
        right = heightMap[i][j + 1];
      } catch (_) {}

      try {
        left = heightMap[i][j - 1];
      } catch (_) {}

      try {
        up = heightMap[i - 1][j];
      } catch (_) {}

      try {
        down = heightMap[i + 1][j];
      } catch (_) {}

      if (heightMap[i][j] < left &&
          heightMap[i][j] < up &&
          heightMap[i][j] < right &&
          heightMap[i][j] < down) {
        lowestPoints.add(heightMap[i][j]);
      }
    }
  }

  return lowestPoints
      .map((e) => e = e + 1)
      .reduce((a, b) => a + b);
}

Future<int> part02() async {
  return 0;
}