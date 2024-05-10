import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCategoryProvider =
    NotifierProvider<SelectedCategoryNotifier, int?>(
        SelectedCategoryNotifier.new);

class SelectedCategoryNotifier extends Notifier<int?> {
  @override
  build() {
    return null;
  }

  void selectedCategory(int ctgryId) {
    state = ctgryId;
  }
}
