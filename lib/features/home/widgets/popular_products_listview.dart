import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/features/home/widgets/product_card.dart';
import 'package:druto/features/root/provider/location_provider.dart';
import 'package:druto/models/hub.dart';
import 'package:druto/models/product_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import '../../../core/theme/theme.dart';

class PopularProductsListview extends ConsumerWidget {
  const PopularProductsListview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hubs = ref.watch(getHubsProvider).valueOrNull;

    final position = ref.watch(getPositionProvider).valueOrNull;

    List<Hub> isLocationWithinAnyHub(
        {required List<Hub> hubs, required LatLng location}) {
      List<Hub> matchingHubs = [];
      for (final hub in hubs) {
        if (PolygonUtil.containsLocation(
          location,
          hub.polygonPoints
              .map((e) => LatLng(e.lat.toDouble(), e.lng.toDouble()))
              .toList(),
          false,
        )) {
          matchingHubs.add(hub);
        }
      }
      return matchingHubs;
    }

    final hub = isLocationWithinAnyHub(
        hubs: hubs!,
        location: LatLng(position!.latitude, position.longitude))[0];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Popular Products",
              style:
                  TextStyle(fontSize: context.f16, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "See All",
                style: TextStyle(
                  fontSize: context.f15,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            )
          ],
        ),
        AsyncValueWidget(
          value:
              ref.watch(getProductsByHubProvider(cid: hub.cId, hid: hub.id!)),
          data: (productLines) {
            return SizedBox(
              height: context.height * 0.25,
              child: ListView.builder(
                itemCount: productLines.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final ProductLine productLine = productLines[index];
                  return AsyncValueWidget(
                    value: ref.watch(isInCartProvider(productLine.id!)),
                    data: (p0) => Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: ProductCard(
                        productLine: productLine,
                        isInCart: p0 == null ? false : true,
                        cart: p0 ?? p0,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
