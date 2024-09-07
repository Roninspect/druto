// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:druto/features/cart/pages/cart_page.dart';
import 'package:druto/models/offer_line.dart';
import 'package:druto/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:druto/models/Offer.dart';
import 'package:go_router/go_router.dart';

class OfferCard extends ConsumerWidget {
  final OfferLine offerLine;
  const OfferCard({
    super.key,
    required this.offerLine,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.pushNamed(AppRoutes.offers.name,
          pathParameters: {"path": offerLine.offers.path}, extra: offerLine),
      child: Container(
        height: 200,
        width: 600,
        child: Image.network(offerLine.offers.banner),
      ),
    );
  }
}
