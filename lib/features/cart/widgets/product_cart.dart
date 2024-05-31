import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/core/helpers/custom_snackbar.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/features/cart/controllers/cart_controller.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/models/cart.dart';
import 'package:druto/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductCartItem extends ConsumerWidget {
  final Cart cart;
  const ProductCartItem(this.cart, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(getProductLineByIdProvider(plId: cart.pl_id!)),
      data: (productLine) {
        final finalSum = productLine.discountedPrice == 0
            ? productLine.price
            : (productLine.price - productLine.discountedPrice);
        return Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.pushNamed(AppRoutes.product.name,
                    extra: productLine),
                child: Image.network(
                  productLine.products!.pic,
                  height: 65,
                  width: 65,
                ),
              ),
              SizedBox(
                width: context.width * 0.03,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => context.pushNamed(AppRoutes.product.name,
                        extra: productLine),
                    child: Text(
                      productLine.products!.name,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: context.height * 0.002,
                  ),
                  Text(
                    productLine.products!.weight,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[500]),
                  ),
                  SizedBox(
                    height: context.height * 0.01,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (cart.quantity > 1) {
                            ref
                                .read(cartControllerProvider.notifier)
                                .decrementItem(
                                    plId: cart.pl_id!, context: context);
                          } else {
                            ref
                                .read(cartControllerProvider.notifier)
                                .removeItemFromCart(
                                    context: context, plId: cart.pl_id);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.remove),
                        ),
                      ),
                      SizedBox(width: context.width * 0.03),
                      Text(
                        "${cart.quantity}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: context.width * 0.03,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (cart.quantity < productLine.limit) {
                            ref
                                .read(cartControllerProvider.notifier)
                                .incrementItem(
                                    plId: cart.pl_id!, context: context);

                            ref.invalidate(getlocalCartItemsProvider);

                            ref.invalidate(isInCartProvider(productLine.id!));
                          } else {
                            showSnackbar(
                              context: context,
                              inTop: true,
                              text:
                                  "You can add ${productLine.limit} ${productLine.products!.name} per order",
                              leadingIcon: Icons.info,
                              backgroundColor: Colors.green,
                            );
                            ref.invalidate(getlocalCartItemsProvider);

                            ref.invalidate(isInCartProvider(productLine.id!));
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.add,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "৳ ${finalSum.toDouble()}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: context.height * 0.015),
                  InkWell(
                    onTap: () {
                      ref
                          .read(cartControllerProvider.notifier)
                          .removeItemFromCart(
                              context: context, plId: cart.pl_id);
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      size: 27,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
