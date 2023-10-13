import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'records_provider.g.dart';

@riverpod
class RecordsNotifier extends _$RecordsNotifier {
  @override
  List<Record> build() {
    return [];
  }

  void clear() {
    state = [];
  }
}
