import 'dart:io';
import 'dart:math';
import 'package:stats/stats.dart';

void main(List<String> arguments) async {
  var content = await File("input.txt").readAsString();
  var values = content.split(",").map((s) => int.parse(s)).toList();

  part1median(values);
  part2(values);
}

num gaussSum(num i) {
  return (pow(i, 2) + i) / 2;
}

void part2(List<int> values) {
  var minV = values.reduce(min);
  var maxV = values.reduce(max);

  num fuelComsumption = 10000000000000000;

  num current = 0;

  for (int i = minV; i < maxV; i++) {
    for (int j = 0; j < values.length; j++) {
      current += gaussSum((i - values[j]).abs());
    }

    if (current < fuelComsumption) {
      fuelComsumption = current;
    }
    current = 0;
  }

  print(fuelComsumption);
}

void part1median(List<num> values) {
  num fuelComsumption = 0;

  var median = Stats.fromData(values).withPrecision(3);
  print(median.median);

  for (int j = 0; j < values.length; j++) {
    fuelComsumption += (median.median - values[j]).abs();
  }
  print(fuelComsumption);
}

void part1bruteforce(List<int> values) {
  var minV = values.reduce(min);
  var maxV = values.reduce(max);

  var fuelComsumption = 10000000;

  var current = 0;

  for (int i = minV; i < maxV; i++) {
    for (int j = 0; j < values.length; j++) {
      current += (i - values[j]).abs();
    }

    if (current < fuelComsumption) {
      fuelComsumption = current;
    }
    current = 0;
  }

  print(fuelComsumption);
}
