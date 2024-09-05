import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfferBanner extends ConsumerWidget {
  const OfferBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: context.height * 0.2,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            'https://c8.alamy.com/comp/2AKGT04/grocery-shopping-promotional-sale-banner-fast-shopping-cart-full-of-fresh-colorful-food-2AKGT04.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
