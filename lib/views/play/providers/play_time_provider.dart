import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'play_time_provider.g.dart';

@riverpod
class PlayTimeNotifier extends _$PlayTimeNotifier {
  @override
  int build() {
    ref.onDispose(() {
      _timer?.cancel();
    });

    return 0;
  }

  final _stopwatch = Stopwatch();
  Timer? _timer;

  void start() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = _stopwatch.elapsed.inSeconds;
    });
  }

  void stop() {
    _stopwatch.stop();
    _timer?.cancel();
  }

  void reset() {
    _stopwatch
      ..stop()
      ..reset();
    _timer?.cancel();
    state = 0;
  }
}
