import 'reader.dart';

void main() async {
  await part01();
  await part02();
}

Future<void> part01() async {
  final report = await readFile('03');
  var gamma = '';

  for (var i = 0; i < report.bitCount; i++) {
    gamma += report.containsMostOnesAtIndex(i) ? '1' : '0';
  }

  final epsilon = gamma.inverted;
  final res = gamma.toDecimal * epsilon.toDecimal;
  assert(res == 2640986);
}

Future<void> part02() async {
  var reportGenerator = await readFile('03');
  var reportScrubber = await readFile('03');

  for (var i = 0; i < reportGenerator.bitCount; i++) {
    if (reportGenerator.length > 1) {
      reportGenerator = reportGenerator.containsMostOnesAtIndex(i)
          ? reportGenerator.filteredOn(i, '1')
          : reportGenerator.filteredOn(i, '0');
    }
    if (reportScrubber.length > 1) {
      reportScrubber = reportScrubber.containsMostOnesAtIndex(i)
          ? reportScrubber.filteredOn(i, '0')
          : reportScrubber.filteredOn(i, '1');
    }
    if (reportGenerator.length == 1 && reportScrubber.length == 1) {
      break;
    }
  }

  final res = reportGenerator.first.toDecimal * reportScrubber.first.toDecimal;
  assert(res == 6822109);
}

extension StringExts on String {
  int get toDecimal => int.parse(this, radix: 2);

  String get inverted => split('').map((e) => e == '1' ? '0' : '1').join();
}

extension ListStringExts on List<String> {
  int get bitCount => first.length - 1;

  int countOf(int index, String c) =>
      map((e) => e[index]).where((e) => e == c).length;

  List<String> filteredOn(int index, String c) =>
      List.of(this).where((e) => e[index] == c).toList();

  bool containsMostOnesAtIndex(int index) =>
      countOf(index, '1') >= countOf(index, '0');
}
