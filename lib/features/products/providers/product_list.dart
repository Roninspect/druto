import 'package:druto/features/products/providers/is_last_page.dart';
import 'package:druto/features/products/providers/page_provider.dart';
import 'package:druto/features/products/repository/products_repository.dart';
import 'package:druto/models/product_line.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final productByCategoryProvider =
    AsyncNotifierProvider<ProductByCategoryNotifier, List<ProductLine>>(
        ProductByCategoryNotifier.new);

class ProductByCategoryNotifier extends AsyncNotifier<List<ProductLine>> {
  Future<List<ProductLine>> initFetch() async {
    final repository = ref.watch(productsRepositoryProvider);
    return await repository.getProductByCategory(ref: ref);
  }

  @override
  Future<List<ProductLine>> build() async {
    // Only fetch data if the current state is null or empty
    if (state.value == null || state.value!.isEmpty) {
      return initFetch();
    }
    return [...state.value!];
  }

  Future<void> loadMore() async {
    ref.read(isLastPageProvider.notifier).setLoadingTrue();

    final repository = ref.watch(productsRepositoryProvider);
    ref.read(selectedPageNoNotifierProvider.notifier).incremnetPage();

    state = await AsyncValue.guard(() async {
      final previous = state.value;

      final List<ProductLine> next = await Future.delayed(
        const Duration(seconds: 3),
        () {
          return repository.getProductByCategory(ref: ref);
        },
      );

      if (next.length < 10) {
        ref.read(isLastPageProvider.notifier).setLastPageTrue();
      }

      final updatedList = [...previous!, ...next];

      print(updatedList.length);

      return updatedList;
    });

    ref.read(isLastPageProvider.notifier).setLoadingFalse();
  }
}
