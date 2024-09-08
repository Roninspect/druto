// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:druto/features/home/widgets/product_card.dart';
import 'package:druto/models/offer_item.dart';
import 'package:druto/models/product_line.dart';
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
        title: Text(offerLine.offers.name),
      ),
      body: AsyncValueWidget(
        value:
            ref.watch(getOfferItemsProvider(ofl_id: offerLine.id, path: path)),
        data: (items) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,
                width: 600,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    offerLine.offers.banner,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            GridView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 238,
              ),
              itemBuilder: (context, index) {
                final ProductLine productLine = items[index].product_line;

                return AsyncValueWidget(
                  value: ref.watch(isInCartProvider(productLine.id!)),
                  data: (p0) => Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: AsyncValueWidget(
                        value: ref.watch(isInCartProvider(productLine.id!)),
                        data: (p0) => Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: ProductCard(
                            productLine: productLine,
                            isInCart: p0 == null ? false : true,
                            cart: p0 ?? p0,
                          ),
                        ),
                      )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
