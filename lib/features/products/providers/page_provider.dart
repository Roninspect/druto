import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'page_provider.g.dart';

@Riverpod(keepAlive: true)
class SelectedPageNoNotifier extends _$SelectedPageNoNotifier {
  @override
  build() {
    return 0;
  }

  void incremnetPage() {
    final pageNo = state! + 1;
    state = pageNo;
  }

  void reset() {
    state = 0;
  }
}
