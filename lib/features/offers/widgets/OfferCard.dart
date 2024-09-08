import 'package:druto/models/offer_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfferCard extends ConsumerWidget {
  final OfferLine offerLine;
  const OfferCard({
    super.key,
    required this.offerLine,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 200,
      width: 600,
      child: Image.network(
        offerLine.offers.banner,
        fit: BoxFit.cover,
      ),
    );
  }
}
