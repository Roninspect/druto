// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/features/package/widgets/counter_bar.dart';
import 'package:druto/models/product.dart';
import 'package:druto/models/product_line.dart';

class ProductDetailsPage extends ConsumerWidget {
  final ProductLine productLine;
  const ProductDetailsPage({
    super.key,
    required this.productLine,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: Padding(
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
                      onPressed: () {},
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
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: context.height * 0.01),
            Text(
              "Weight: ${product.weight}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                const CounterBar(),
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
                Center(
                  child: SizedBox(
                    width: context.width * 0.45,
                    child: FloatingActionButton.extended(
                      backgroundColor: primaryColor,
                      onPressed: () {},
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
              ],
            ),
            SizedBox(
              height: context.height * 0.03,
            ),
            Text(
              "Product Details",
              style:
                  TextStyle(fontSize: context.f16, fontWeight: FontWeight.bold),
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
              style: TextStyle(fontSize: context.f15),
            ),
            SizedBox(
              height: context.height * 0.02,
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
