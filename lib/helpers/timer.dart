import '/constants/timer.dart';

bool hasSharedAlpha(String line) {
  final alpha = alphaBeta.split('').toList();
  if (alpha.contains(line[0])) {
    return true;
  }

  return false;
}