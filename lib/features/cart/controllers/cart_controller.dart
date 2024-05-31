// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:druto/core/helpers/custom_snackbar.dart';
import 'package:druto/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final cartControllerProvider =
    StateNotifierProvider<CartController, bool>((ref) {
  return CartController(
      localCartRepository: ref.watch(localCartProvider), ref: ref);
});

class CartController extends StateNotifier<bool> {
  final LocalCartRepository localCartRepository;
  final Ref ref;
  CartController({required this.localCartRepository, required this.ref})
      : super(false);

  Future<void> addToCart(Cart localIds) async {
    try {
      state = true;
      if (Supabase.instance.client.auth.currentUser == null) {
        await localCartRepository.addToLocalCart(localIds: localIds);
      } else {}
      ref.invalidate(getlocalCartItemsProvider);
      localIds.pl_id == null
          ? ref.invalidate(isPackageInCartProvider(localIds.pckgl_id!))
          : ref.invalidate(isInCartProvider(localIds.pl_id!));

      state = false;
    } catch (e) {}
  }

  Future<void> incrementItem(
      {int? plId, int? pckgl_id, required BuildContext context}) async {
    state = true;
    final res = await localCartRepository.incrementItem(
        plId: plId ?? plId, pckglId: pckgl_id ?? pckgl_id);
    state = false;
    res.fold(
        (l) => showSnackbar(
            leadingIcon: Icons.warning_amber,
            context: context,
            text: l.message,
            backgroundColor: Colors.red), (r) {
      ref.invalidate(getlocalCartItemsProvider);
      plId == null
          ? ref.invalidate(isPackageInCartProvider(pckgl_id!))
          : ref.invalidate(isInCartProvider(plId));
    });
  }

  Future<void> decrementItem(
      {int? plId, int? pckg_id, required BuildContext context}) async {
    state = true;
    final res = await localCartRepository.decrementItem(
        plId: plId ?? plId, pckgId: pckg_id ?? pckg_id);
    state = false;
    res.fold(
        (l) => showSnackbar(
            leadingIcon: Icons.warning_amber,
            context: context,
            text: l.message,
            backgroundColor: Colors.red), (r) {
      ref.invalidate(getlocalCartItemsProvider);
      plId == null
          ? ref.invalidate(isPackageInCartProvider(pckg_id!))
          : ref.invalidate(isInCartProvider(plId));
    });
  }

  Future<void> removeItemFromCart(
      {int? plId, int? pckgId, required BuildContext context}) async {
    final res = await localCartRepository.removeItemFromCart(
        pckgId: pckgId ?? pckgId, plId: plId ?? plId);

    res.fold(
        (l) => showSnackbar(
            leadingIcon: Icons.warning_amber,
            context: context,
            text: l.message,
            backgroundColor: Colors.red), (r) {
      ref.invalidate(getlocalCartItemsProvider);
      plId == null
          ? ref.invalidate(isPackageInCartProvider(pckgId!))
          : ref.invalidate(isInCartProvider(plId));
      showSnackbar(
          context: context,
          leadingIcon: Icons.shopping_bag,
          inTop: true,
          text: pckgId == null
              ? "Product Removed from Cart"
              : "Package Removed from Cart",
          backgroundColor: Colors.amber);
    });
  }
}
