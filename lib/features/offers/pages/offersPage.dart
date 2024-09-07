// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/models/offer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:druto/features/offers/repository/offer_repository.dart';
import 'package:druto/models/offer_line.dart';

class OffersPage extends ConsumerWidget {
  final OfferLine offerLine;
  final String path;
  const OffersPage({
    super.key,
    required this.offerLine,
    required this.path,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(path),
      ),
      body: AsyncValueWidget(
        value:
            ref.watch(getOfferItemsProvider(ofl_id: offerLine.id, path: path)),
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final OfferItem item = items[index];

            return Text(item.product_line.products!.name);
          },
        ),
      ),
    );
  }
}
