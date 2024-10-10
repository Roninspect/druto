import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/features/home/widgets/package_card.dart';
import 'package:druto/features/root/provider/location_provider.dart';
import 'package:druto/models/hub.dart';
import 'package:druto/models/package_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

import '../../../core/theme/theme.dart';

class PopularPackageListview extends ConsumerWidget {
  const PopularPackageListview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hubs = ref.watch(getHubsProvider).valueOrNull;
    final position = ref.watch(isPositionNotifierProvider);

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
              "Popular Packs",
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
                ))
          ],
        ),
        AsyncValueWidget(
          value: ref.watch(getPackagesByHubIdProvider(hId: hub.id!)),
          data: (packages) => SizedBox(
            height: context.height * 0.3,
            child: ListView.builder(
              itemCount: packages.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final PackageLine packageLine = packages[index];

                return AsyncValueWidget(
                  value: ref.watch(isPackageInCartProvider(packageLine.id!)),
                  data: (p0) {
                    return SizedBox(
                      height: 10,
                      child: PackageCard(
                        packageLine: packageLine,
                        isInCart: p0 == null ? false : true,
                        cart: p0 ?? p0,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
