// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/features/cart/controllers/cart_controller.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/features/root/provider/location_provider.dart';
import 'package:druto/models/cart.dart';
import 'package:druto/models/hub.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/models/package.dart';
import 'package:druto/routes/router.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

class BundleCard extends ConsumerStatefulWidget {
  final Package package;
  const BundleCard({
    super.key,
    required this.package,
  });

  @override
  ConsumerState<BundleCard> createState() => _BundleCardState();
}

class _BundleCardState extends ConsumerState<BundleCard> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
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
    return Padding(
      padding: EdgeInsets.all(context.width * 0.02),
      child: GestureDetector(
        onTap: () =>
            context.pushNamed(AppRoutes.bundle.name, extra: widget.package),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.02, vertical: context.width * 0.02),
          decoration: BoxDecoration(
              border: Border.all(width: 0.1),
              borderRadius: BorderRadius.circular(context.height * 0.01)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.package.cover,
                height: context.height * 0.1,
                fit: BoxFit.contain,
              ),
              SizedBox(height: context.height * 0.01),
              Text(
                widget.package.name,
                style: TextStyle(
                    fontSize: context.width * 0.045,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: context.height * 0.01),
              AsyncValueWidget(
                value: ref.watch(getPackageItemsProvider(
                    pckgId: widget.package.id!, hId: hub.id!)),
                data: (packageItems) {
                  final sum = packageItems.fold<double>(
                      0,
                      (value, element) =>
                          value +
                          (element.product_line!.discountedPrice == 0
                              ? element.product_line!.price
                              : (element.product_line!.price -
                                  element.product_line!.discountedPrice)));

                  final mainsum = packageItems.fold<double>(0,
                      (value, element) => value + element.product_line!.price);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "৳$sum",
                        style: TextStyle(
                            fontSize: context.f16,
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                      ),
                      SizedBox(width: context.width * 0.01),
                      Text(
                        "৳$mainsum",
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationStyle: TextDecorationStyle.solid,
                            color: Colors.grey),
                      ),
                      SizedBox(width: context.width * 0.15),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });

                          await ref
                              .read(cartControllerProvider.notifier)
                              .addToCart(
                                Cart(
                                  id: widget.package.id,
                                  pckg_id: widget.package.id,
                                  quantity: 1,
                                ),
                              );

                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: CircleAvatar(
                          radius: context.height * 0.02,
                          backgroundColor: primaryColor,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: context.height * 0.03,
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
