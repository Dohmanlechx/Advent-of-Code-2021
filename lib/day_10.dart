import 'package:Advent_of_Code_2021/reader.dart';

class Solution {
  int? p1;
  int? p2;
}

void main() async {
  final solution = await bothParts();
  assert(solution.p1 == 388713);
  assert(solution.p2 == 3539961434);
}

Future<Solution> bothParts() async {
  final input = await readFile('10');
  final solution = Solution();

  var illegalChars = <String>[];
  var incompleteLines = <List<String>>[];

  for (var line in input) {
    var copy = line.split('');
    for (var i = 0; i < line.length - 1; i++) {
      if (copy[i] == ')') {
        illegalChars.add(')');
        break;
      } else if (copy[i] == '}') {
        illegalChars.add('}');
        break;
      } else if (copy[i] == ']') {
        illegalChars.add(']');
        break;
      } else if (copy[i] == '>') {
        illegalChars.add('>');
        break;
      }

      if (i == copy.length - 1) {
        incompleteLines.add(copy);
        break;
      }

      if (copy[i] + copy[i + 1] == '()' ||
          copy[i] + copy[i + 1] == '{}' ||
          copy[i] + copy[i + 1] == '[]' ||
          copy[i] + copy[i + 1] == '<>') {
        copy.removeAt(i);
        copy.removeAt(i);
        i = -1;
      }
    }
  }

  var sum = 0;
  sum += (illegalChars.where((e) => e == ')')).length * 3;
  sum += (illegalChars.where((e) => e == ']')).length * 57;
  sum += (illegalChars.where((e) => e == '}')).length * 1197;
  sum += (illegalChars.where((e) => e == '>')).length * 25137;

  solution.p1 = sum;

  var sums = <int>[];
  for (var line in incompleteLines) {
    var sum = 0;
    for (var i = line.length - 1; i >= 0; i--) {
      if (line[i] == '(') {
        sum = (sum * 5) + 1;
      } else if (line[i] == '[') {
        sum = (sum * 5) + 2;
      } else if (line[i] == '{') {
        sum = (sum * 5) + 3;
      } else if (line[i] == '<') {
        sum = (sum * 5) + 4;
      }
    }
    sums.add(sum);
  }
  sums.sort();
  solution.p2 = sums[(sums.length - 1) ~/ 2];

  return solution;
}
