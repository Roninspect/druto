import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:druto/features/cart/widgets/package_cart.dart';
import 'package:druto/features/cart/widgets/product_cart.dart';
import 'package:druto/features/cart/widgets/total_bar.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/features/products/controllers/products_controller.dart';
import 'package:druto/models/cart.dart';
import 'package:druto/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        bottom:
            const PreferredSize(preferredSize: Size(0, 0), child: Divider()),
      ),
      body: AsyncValueWidget(
        value: Supabase.instance.client.auth.currentUser != null
            ? ref.watch(getlocalCartItemsProvider)
            : ref.watch(getlocalCartItemsProvider),
        data: (carts) {
          return carts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        MaterialCommunityIcons.cart_remove,
                        size: context.height * 0.12,
                      ),
                      SizedBox(
                        height: context.height * 0.02,
                      ),
                      const Text(
                        "Your Shopping Cart is Empty",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22),
                      )
                    ],
                  ),
                )
              : AsyncValueWidget(
                  value: ref.watch(getHubsProvider),
                  data: (p0) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: context.height * 0.42,
                              child: ListView.separated(
                                itemCount: carts.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  endIndent: 20,
                                  indent: 20,
                                  thickness: 0.6,
                                ),
                                itemBuilder: (context, index) {
                                  final Cart cart = carts[index];

                                  return cart.pl_id != null
                                      ? ProductCartItem(cart)
                                      : PackageCartItem(cart: cart);
                                },
                              ),
                            ),
                            SizedBox(height: context.height * 0.01),
                            carts.isEmpty
                                ? const SizedBox.shrink()
                                : TotalBar(carts),
                            carts.isEmpty
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: SizedBox(
                                      width: context.width * 039,
                                      child: FloatingActionButton.extended(
                                        backgroundColor: Colors.green,
                                        label: const Text(
                                          "Checkout",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        onPressed: () => carts.isEmpty
                                            ? () {}
                                            : context.pushNamed(
                                                AppRoutes.checkout.name),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
