import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'page_number_provider.g.dart';

@riverpod
class PageNumberNotifier extends _$PageNumberNotifier {
  @override
  int build() {
    return 1;
  }

  @override
  set state(int num);

  void increase() {
    state++;
  }

  void decrease() {
    state--;
  }
}
