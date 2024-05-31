// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:druto/core/helpers/custom_snackbar.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:druto/models/package_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/features/cart/controllers/cart_controller.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/features/root/provider/location_provider.dart';
import 'package:druto/models/cart.dart';
import 'package:druto/models/hub.dart';
import 'package:druto/routes/router.dart';

class PackageCard extends ConsumerStatefulWidget {
  final PackageLine packageLine;
  final bool isInCart;
  final Cart? cart;
  const PackageCard({
    super.key,
    required this.packageLine,
    required this.isInCart,
    this.cart,
  });

  @override
  ConsumerState<PackageCard> createState() => _BundleCardState();
}

class _BundleCardState extends ConsumerState<PackageCard> {
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
            context.pushNamed(AppRoutes.bundle.name, extra: widget.packageLine),
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
                widget.packageLine.package!.cover,
                height: context.height * 0.1,
                fit: BoxFit.contain,
              ),
              SizedBox(height: context.height * 0.01),
              SizedBox(
                width: context.width * 0.4,
                child: Text(
                  widget.packageLine.package!.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: context.width * 0.045,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: context.height * 0.01),
              AsyncValueWidget(
                value: ref.watch(getPackageItemsProvider(
                    pckgId: widget.packageLine.package!.id!, hId: hub.id!)),
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
                      SizedBox(width: context.width * 0.05),
                    ],
                  );
                },
              ),
              widget.cart == null && !widget.isInCart
                  ? InkWell(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });

                        print("ATC: ${Cart(
                          id: widget.packageLine.id,
                          pckgl_id: widget.packageLine.id,
                          pckg_id: widget.packageLine.pckg_id,
                          quantity: 1,
                        )}");

                        await ref
                            .read(cartControllerProvider.notifier)
                            .addToCart(
                              Cart(
                                id: widget.packageLine.id,
                                pckgl_id: widget.packageLine.id,
                                pckg_id: widget.packageLine.pckg_id,
                                quantity: 1,
                              ),
                            );

                        ref.invalidate(
                            isPackageInCartProvider(widget.packageLine.id!));

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Container(
                        width: context.width * 0.4,
                        height: context.height * 0.04,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 2),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                            child: Text(
                          "Add To Cart",
                          style: TextStyle(
                              fontSize: 15,
                              color: primaryColor,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    )
                  : Container(
                      width: context.width * 0.4,
                      height: context.height * 0.04,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (widget.cart!.quantity > 1) {
                                ref
                                    .read(cartControllerProvider.notifier)
                                    .decrementItem(
                                        pckg_id: widget.cart!.pckgl_id!,
                                        context: context);
                                ref.invalidate(isPackageInCartProvider(
                                    widget.packageLine.id!));
                              } else {
                                ref
                                    .read(cartControllerProvider.notifier)
                                    .removeItemFromCart(
                                        context: context,
                                        pckgId: widget.cart!.pckgl_id);
                                ref.invalidate(isPackageInCartProvider(
                                    widget.packageLine.id!));
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(
                                Icons.remove,
                                color: Colors.green[800],
                              ),
                            ),
                          ),
                          SizedBox(width: context.width * 0.03),
                          Text(
                            "${widget.cart!.quantity}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: context.width * 0.03,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (widget.cart!.quantity <
                                  widget.packageLine.limit!) {
                                ref
                                    .read(cartControllerProvider.notifier)
                                    .incrementItem(
                                        pckgl_id: widget.cart!.pckgl_id!,
                                        context: context);

                                ref.invalidate(isPackageInCartProvider(
                                    widget.packageLine.id!));
                              } else {
                                showSnackbar(
                                  context: context,
                                  inTop: true,
                                  text:
                                      "You can add ${widget.packageLine.limit} ${widget.packageLine.package!.name} per order",
                                  leadingIcon: Icons.info,
                                  backgroundColor: Colors.green,
                                );

                                ref.invalidate(isPackageInCartProvider(
                                    widget.packageLine.id!));
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(5)),
                              child: Icon(
                                Icons.add,
                                color: Colors.green[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
