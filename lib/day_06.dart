import 'reader.dart';

void main() async {
  final p1 = await calculateFish(80);
  final p2 = await calculateFish(256);
  assert(p1 == 379114);
  assert(p2 == 1702631502303);
}

Future<int> calculateFish(int days) async {
  final input = await readFile('06', ',');

  var fishList = input.map((e) => int.parse(e)).toList();

  final fishOfTimer = <int, int>{
    0: fishList.where((e) => e == 0).length,
    1: fishList.where((e) => e == 1).length,
    2: fishList.where((e) => e == 2).length,
    3: fishList.where((e) => e == 3).length,
    4: fishList.where((e) => e == 4).length,
    5: fishList.where((e) => e == 5).length,
    6: fishList.where((e) => e == 6).length,
    7: fishList.where((e) => e == 7).length,
    8: fishList.where((e) => e == 8).length,
  };

  for (var i = 0; i < days; i++) {
    final drainedFishCount = fishOfTimer[0];
    for (var j = 0; j <= 8; j++) {
      if (j == 6) {
        fishOfTimer[j] = fishOfTimer[j + 1]! + drainedFishCount!;
      } else if (j < 8) {
        fishOfTimer[j] = fishOfTimer[j + 1]!;
      } else {
        fishOfTimer[8] = drainedFishCount!;
      }
    }
  }

  final res = fishOfTimer.values
      .fold(0, (int previousValue, int element) => previousValue + element);

  return res;
}
