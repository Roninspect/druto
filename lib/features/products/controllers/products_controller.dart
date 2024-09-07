// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:druto/features/products/repository/products_repository.dart';

final productsControllerProvider =
    StateNotifierProvider<ProductsController, bool>((ref) {
  return ProductsController(ref.watch(productsRepositoryProvider), ref);
});

class ProductsController extends StateNotifier<bool> {
  final ProductsRepository productsRepository;
  final Ref ref;
  ProductsController(
    this.productsRepository,
    this.ref,
  ) : super(false);

  Future<void> deleteInactiveItems({int? pl_id, int? pckgL_id}) async {
    if (pl_id != null) {
      final res = await productsRepository.deleteInactiveItemFromCart(
          hubId: 1, pl_id: pl_id);
      res.fold(
        (l) => print(l.message),
        (r) async {
          if (r.isEmpty) {
            final res = await ref
                .read(localCartProvider)
                .removeItemFromCart(plId: pl_id);

            res.fold(
              (l) => print(l.message),
              (r) {
                ref.invalidate(getlocalCartItemsProvider);
                ref.invalidate(isInCartProvider);
    
              },
            );
          }
        },
      );
    } else {
      final res = await productsRepository.deleteInactiveItemFromCart(
          hubId: 1, pckgL_id: pckgL_id);
      res.fold(
        (l) => print(l.message),
        (r) async {
          if (r.isEmpty) {
            final res = await ref
                .read(localCartProvider)
                .removeItemFromCart(pckgId: pckgL_id);

            res.fold(
              (l) => print(l.message),
              (r) {
                ref.invalidate(getlocalCartItemsProvider);
                ref.invalidate(isPackageInCartProvider);
         
              },
            );
          }
        },
      );
    }

  }
}
