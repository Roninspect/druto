// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:druto/features/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/features/cart/controllers/cart_controller.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:druto/models/cart.dart';
import 'package:druto/models/product_line.dart';
import 'package:druto/routes/router.dart';

class ProductCard extends ConsumerStatefulWidget {
  final ProductLine productLine;
  final bool isInCart;
  Cart? cart;
  ProductCard({
    super.key,
    required this.productLine,
    required this.isInCart,
    this.cart,
  });

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final finalSum = widget.productLine.discountedPrice == 0
        ? widget.productLine.price
        : (widget.productLine.price - widget.productLine.discountedPrice);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 0.1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => context.pushNamed(AppRoutes.product.name,
                extra: widget.productLine),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.productLine.products!.pic,
                  height: context.height * 0.09,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: context.height * 0.005),
                SizedBox(
                  width: context.midOverflow * 0.8,
                  child: Text(
                    widget.productLine.products!.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: context.f15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                ),
                Text(
                  widget.productLine.products!.weight,
                  style: TextStyle(
                      fontSize: context.f15, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: context.height * 0.005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "৳$finalSum",
                      style: TextStyle(
                          fontSize: context.f16,
                          fontWeight: FontWeight.w900,
                          color: Colors.black),
                    ),
                    SizedBox(width: context.width * 0.01),
                    widget.productLine.discountedPrice == 0
                        ? const SizedBox.shrink()
                        : Text(
                            "৳${widget.productLine.price}",
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationStyle: TextDecorationStyle.solid,
                                color: Colors.grey),
                          ),
                    SizedBox(
                      width: context.width * 0.05,
                    ),
                    widget.isInCart
                        ? const SizedBox.shrink()
                        : InkWell(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });

                              await ref
                                  .read(cartControllerProvider.notifier)
                                  .addToCart(
                                    Cart(
                                      id: widget.productLine.id,
                                      p_id: widget.productLine.pId,
                                      pl_id: widget.productLine.id!,
                                      quantity: 1,
                                    ),
                                  );

                              ref.invalidate(
                                  isInCartProvider(widget.productLine.id!));

                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: CircleAvatar(
                              radius: context.height * 0.02,
                              backgroundColor: primaryColor,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: context.height * 0.03,
                              ),
                            ),
                          )
                  ],
                ),
              ],
            ),
          ),
          widget.cart == null && !widget.isInCart
              ? const SizedBox.shrink()
              : Container(
                  width: 150,
                  height: 30,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (widget.cart!.quantity > 1) {
                            ref
                                .read(cartControllerProvider.notifier)
                                .decrementItem(
                                    plId: widget.cart!.pl_id!,
                                    context: context);
                            ref.invalidate(
                                isInCartProvider(widget.productLine.id!));
                          } else {
                            ref
                                .read(cartControllerProvider.notifier)
                                .removeItemFromCart(
                                    context: context, plId: widget.cart!.pl_id);
                            ref.invalidate(
                                isInCartProvider(widget.productLine.id!));
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(5)),
                          child: Icon(
                            Icons.remove,
                            color: Colors.green[800],
                          ),
                        ),
                      ),
                      SizedBox(width: context.width * 0.03),
                      Text(
                        "${widget.cart!.quantity}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: context.width * 0.03,
                      ),
                      GestureDetector(
                        onTap: () {
                          ref
                              .read(cartControllerProvider.notifier)
                              .incrementItem(
                                  plId: widget.cart!.pl_id!, context: context);

                          ref.invalidate(
                              isInCartProvider(widget.productLine.id!));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(5)),
                          child: Icon(
                            Icons.add,
                            color: Colors.green[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
