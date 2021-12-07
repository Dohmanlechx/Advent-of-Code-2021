import 'dart:math';

import 'reader.dart';

void main() async {
  final input = await readFile('07', ',');
  final crabs = input.map((e) => int.parse(e)).toList()..sort();
  final positions = [for (var i = crabs.first; i < crabs.last; i++) i];

  final p1 = part01(crabs, positions);
  final p2 = part02(crabs, positions);
  assert(p1 == 328262);
  assert(p2 == 90040997);
}

int part01(
  List<int> crabs,
  List<int> positions,
) {
  var leastFuel = 0x7fffffff;
  for (var position in positions) {
    var fuelTank = 0;
    for (var crab in crabs) {
      fuelTank += (crab - position).abs();
    }
    if (leastFuel > fuelTank) {
      leastFuel = fuelTank;
    }
  }
  return leastFuel;
}

int part02(
  List<int> crabs,
  List<int> positions,
) {
  var leastFuel = 0x7fffffff;
  for (var position in positions) {
    var fuelTank = 0;
    for (var crab in crabs) {
      var step = 1;
      for (var i = min(crab, position); i < max(crab, position); i++) {
        fuelTank += step++;
      }
    }
    if (leastFuel > fuelTank) {
      leastFuel = fuelTank;
    }
  }
  return leastFuel;
}
