// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:druto/models/product_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/features/cart/controllers/cart_controller.dart';
import 'package:druto/models/product.dart';
import 'package:druto/routes/router.dart';

class ProductCard extends ConsumerStatefulWidget {
  final ProductLine productLine;
  const ProductCard({
    super.key,
    required this.productLine,
  });

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: GestureDetector(
        onTap: () => context.pushNamed(AppRoutes.product.name,
            extra: widget.productLine),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
              border: Border.all(width: 0.1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.productLine.products!.pic,
                height: 95,
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
                    "\$${widget.productLine.discountedPrice}",
                    style: TextStyle(
                        fontSize: context.f16,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
                  SizedBox(width: context.width * 0.01),
                  Text(
                    "\$${widget.productLine.price}",
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationStyle: TextDecorationStyle.solid,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    width: context.width * 0.15,
                  ),
                  isLoading
                      ? const CircularProgressIndicator()
                      : InkWell(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            // await ref
                            //     .read(cartControllerProvider.notifier)
                            //     .addToCart(
                            //       Cart(
                            //         id: 2,
                            //         pId: 1,
                            //         plId: 1,
                            //         quantity: 1,
                            //       ),
                            //     );

                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundColor: primaryColor,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
