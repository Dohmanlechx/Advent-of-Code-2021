import 'dart:io';

Future<List<String>> readFile(
  String day, [
  String split = '\n',
]) async {
  final file = File('./assets/day_$day');
  final input = await file.readAsString();
  return input.split(split);
}
