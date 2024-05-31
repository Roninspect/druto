import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/features/home/widgets/product_card.dart';
import 'package:druto/features/root/provider/location_provider.dart';
import 'package:druto/features/search/providers/search_query_provider.dart';
import 'package:druto/features/search/repository/search_repository.dart';
import 'package:druto/models/hub.dart';
import 'package:druto/models/product_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

class SearchResultListView extends ConsumerWidget {
  const SearchResultListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hubs = ref.watch(getHubsProvider).valueOrNull;

    final String query = ref.watch(searchQueryProvider);

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
    return AsyncValueWidget(
      value: ref.watch(searchProductsProvider(hubId: hub.id!, query: query)),
      data: (items) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${items.length} Items Found for term $query",
              style: const TextStyle(fontSize: 17),
            ),
          ),
          Expanded(
              child: GridView.builder(
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 238,
            ),
            itemBuilder: (context, index) {
              final ProductLine productLine = items[index];

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
          ))
        ],
      ),
    );
  }
}
