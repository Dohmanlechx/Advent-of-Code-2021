import 'dart:math';

import 'reader.dart';

void main() async {
  await part01();
}

Future<void> part01() async {
  final input = await readFile('05');

  var vents = <Vent>[];
  var coordinates = <Coordinate>[];

  for (var entry in input) {
    final x1 = int.parse(entry.split(' -> ').first.split(',').first);
    final y1 = int.parse(entry.split(' -> ').first.split(',').last);
    final x2 = int.parse(entry.split(' -> ').last.split(',').first);
    final y2 = int.parse(entry.split(' -> ').last.split(',').last);

    if (x1 == x2) {
      for (var i = min(y1, y2); i <= max(y1, y2); i++) {
        coordinates.add(Coordinate(x1, i));
      }
    }
    if (y1 == y2) {
      for (var i = min(x1, x2); i <= max(x1, x2); i++) {
        coordinates.add(Coordinate(i, y1));
      }
    }

    vents.add(Vent(coordinates));
  }

  final coordinatesAsSet = coordinates.toSet().toList();

  print(coordinates.length - coordinatesAsSet.length);
}

class Vent {
  final List<Coordinate> coordinates;

  const Vent(this.coordinates);
}

class Coordinate {
  final int x;
  final int y;

  const Coordinate(this.x, this.y);

  @override
  bool operator ==(covariant Coordinate other) {
    return (x == other.x && y == other.y);
  }

  @override
  int get hashCode => x + y;

  @override
  String toString() => '[$x, $y]';
}
