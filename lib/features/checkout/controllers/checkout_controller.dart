import 'dart:convert';
import 'package:druto/core/constants/order_enums.dart';
import 'package:druto/core/helpers/custom_snackbar.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:druto/features/checkout/repository/checkout_repository.dart';
import 'package:druto/models/cart.dart';
import 'package:druto/models/order.dart';
import 'package:druto/models/order_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final checkoutControllerProvider =
    StateNotifierProvider<CheckoutController, bool>((ref) {
  return CheckoutController(
      ref: ref, checkoutRepository: ref.watch(checkoutRepositoryProvider));
});

class CheckoutController extends StateNotifier<bool> {
  CheckoutRepository checkoutRepository;
  Ref ref;
  CheckoutController({required this.checkoutRepository, required this.ref})
      : super(false);

  Future<void> placeOrder({
    required UserOrder order,
    required BuildContext context,
    required List<Cart> items,
  }) async {
    state = true;
    final basicRes = await checkoutRepository.placeBasicOrder(order);

    basicRes.fold((l) {
      showSnackbar(
          leadingIcon: Icons.warning_amber,
          context: context,
          text: l.message,
          backgroundColor: Colors.red);
    }, (r) async {
      List<OrderProducts> list = items
          .map((e) {
            if (e.pl_id != null) {
              return OrderProducts(
                  o_id: r, order_type: OrderType.Product, pl_id: e.pl_id);
            } else {
              return OrderProducts(
                  o_id: r, order_type: OrderType.Package, pckg_id: e.pckg_id);
            }
          })
          .whereType<OrderProducts>()
          .toList();

      final itemsRes = await checkoutRepository.placeAllOrderProducts(list);

      state = false;

      itemsRes.fold((l) {
        showSnackbar(
            leadingIcon: Icons.warning_amber,
            context: context,
            text: l.message,
            backgroundColor: Colors.red);
      }, (r) async {
        final sharefPref = await SharedPreferences.getInstance();

        await sharefPref.setString("cart", jsonEncode([]));

        ref.invalidate(getlocalCartItemsProvider);
        if (mounted) {
          context.pop();
          showSnackbar(
              leadingIcon: Icons.done,
              context: context,
              text: "Order Confirmed Successfully",
              backgroundColor: Colors.green);
        }
      });
    });
  }
}
