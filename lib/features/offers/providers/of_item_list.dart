import 'package:druto/features/offers/providers/of_is_lasr_page.dart';
import 'package:druto/features/offers/providers/of_page_provider.dart';
import 'package:druto/features/offers/repository/offer_repository.dart';
import 'package:druto/features/products/providers/is_last_page.dart';
import 'package:druto/features/products/providers/page_provider.dart';
import 'package:druto/features/products/repository/products_repository.dart';
import 'package:druto/models/offer_item.dart';
import 'package:druto/models/product_line.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'of_item_list.g.dart';

// final productByCategoryProvider =
//     AsyncNotifierProvider<ProductByCategoryNotifier, List<ProductLine>>(
//         ProductByCategoryNotifier.new);

@Riverpod(keepAlive: false)
class OfferItemsList extends _$OfferItemsList {
  Future<List<OfferItem>> initFetch(
      {required int ofl_id, required String path}) async {
    final repository = ref.watch(offerRepositoryProvider);
    return await repository.getOfferItems(ofl_id: ofl_id, path: path);
  }

  @override
  Future<List<OfferItem>> build(
      {required int ofl_id, required String path}) async {
    if (state.value == null || state.value!.isEmpty) {
      return initFetch(ofl_id: ofl_id, path: path);
    }
    return [...state.value!];
  }

  // void dispose() {
  //   ref.onDispose(() async {
  //     ref.invalidate(selectedPageNoNotifierProvider);
  //   });
  // }

  Future<void> loadMore({required int ofl_id, required String path}) async {
    ref.read(ofIsLastPageProvider.notifier).setLoadingTrue();

    final repository = ref.watch(offerRepositoryProvider);
    ref.read(ofSelectedPageNoNotifierProvider.notifier).incremnetPage();

    state = await AsyncValue.guard(() async {
      final previous = state.value;

      final List<OfferItem> next = await Future.delayed(
        const Duration(seconds: 3),
        () {
          return repository.getOfferItems(ofl_id: ofl_id, path: path);
        },
      );

      if (next.length < 10) {
        ref.read(ofIsLastPageProvider.notifier).setLastPageTrue();
      }

      final updatedList = [...previous!, ...next];



      return updatedList;
    });

    ref.read(ofIsLastPageProvider.notifier).setLoadingFalse();
  }
}
