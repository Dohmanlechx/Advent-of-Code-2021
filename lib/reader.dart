import 'dart:io';

Future<List<String>> readFile(String day) async {
  final file = File('./assets/day_$day');
  final input = await file.readAsString();
  return input.split('\n');
}
