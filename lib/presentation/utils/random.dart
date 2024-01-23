import 'dart:math';

int generateRandomId({int length = 8}) {
  final random = Random();
  final minValue = pow(10, length - 1);
  final maxValue = pow(10, length) - 1;

  return minValue.toInt() + random.nextInt(maxValue.toInt() - minValue.toInt());
}