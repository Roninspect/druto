// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/core/helpers/custom_snackbar.dart';
import 'package:druto/features/cart/controllers/cart_controller.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:druto/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/features/package/widgets/counter_bar.dart';
import 'package:druto/models/product.dart';
import 'package:druto/models/product_line.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductDetailsPage extends ConsumerWidget {
  final ProductLine productLine;
  const ProductDetailsPage({
    super.key,
    required this.productLine,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int quantity = ref.watch(itemQuantityProvider);
    final product = productLine.products!;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Product Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_bag,
              ),
            )
          ],
        ),
        body: AsyncValueWidget(
          value: ref.watch(isInCartProvider(productLine.id!)),
          data: (cart) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.height * 0.02),
                Container(
                  color: Colors.grey[200],
                  child: Center(
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.network(
                          product.pic,
                          width: context.width * 0.95,
                          height: context.height * 0.3,
                        ),
                        IconButton(
                          onPressed: () {
                            if (Supabase.instance.client.auth.currentUser ==
                                null) {
                              showSnackbar(
                                  context: context,
                                  text:
                                      "Please Log In to Favorite ${product.name}",
                                  leadingIcon: Icons.warning_amber_rounded,
                                  backgroundColor: Colors.red);
                            }
                          },
                          icon: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey[300],
                            child: const Icon(
                              Icons.favorite_outline,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: context.height * 0.02),
                Text(
                  product.name,
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: context.height * 0.01),
                Text(
                  "Weight: ${product.weight}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: context.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "৳${productLine.price}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationThickness: 2,
                          ),
                        ),
                        SizedBox(
                          width: context.width * 0.02,
                        ),
                        Text(
                          "৳${productLine.discountedPrice}",
                          style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ),
                      ],
                    ),
                    cart != null ? const SizedBox.shrink() : const CounterBar(),
                  ],
                ),
                SizedBox(
                  height: context.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: SizedBox(
                        width: context.width * 0.45,
                        child: FloatingActionButton.extended(
                          heroTag: "Buy Now",
                          backgroundColor: primaryColor,
                          onPressed: () {},
                          isExtended: true,
                          label: Text(
                            "Buy Now",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: context.f15),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Center(
                        child: cart != null
                            ? Container(
                                width: 160,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    border: Border.all(
                                        color: Colors.green, width: 2),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (cart.quantity > 1) {
                                          ref
                                              .read(cartControllerProvider
                                                  .notifier)
                                              .decrementItem(
                                                  plId: cart.pl_id!,
                                                  context: context);
                                          ref.invalidate(isInCartProvider(
                                              productLine.id!));
                                        } else {
                                          ref
                                              .read(cartControllerProvider
                                                  .notifier)
                                              .removeItemFromCart(
                                                  context: context,
                                                  plId: cart.pl_id);
                                          ref.invalidate(isInCartProvider(
                                              productLine.id!));
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: const Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${cart.quantity}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(
                                                cartControllerProvider.notifier)
                                            .incrementItem(
                                                plId: cart.pl_id!,
                                                context: context);

                                        ref.invalidate(
                                            isInCartProvider(productLine.id!));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(
                                width: context.width * 0.45,
                                child: FloatingActionButton.extended(
                                  heroTag: "ATC",
                                  backgroundColor: primaryColor,
                                  onPressed: () async {
                                    await ref
                                        .read(cartControllerProvider.notifier)
                                        .addToCart(
                                          Cart(
                                            id: productLine.id,
                                            p_id: productLine.pId,
                                            pl_id: productLine.id!,
                                            quantity: quantity,
                                          ),
                                        );
                                  },
                                  isExtended: true,
                                  label: Row(
                                    children: [
                                      const Icon(
                                        Icons.shopping_bag,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: context.width * 0.02),
                                      Text(
                                        "Add To Cart",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: context.f15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: context.height * 0.03,
                ),
                Text(
                  "Product Details",
                  style: TextStyle(
                      fontSize: context.f16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                  style: TextStyle(fontSize: context.f15),
                ),
                SizedBox(
                  height: context.height * 0.02,
                ),
              ],
            ),
          ),
        ));
  }
}
