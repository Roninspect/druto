import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/core/helpers/custom_snackbar.dart';
import 'package:druto/features/cart/controllers/cart_controller.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/features/root/provider/location_provider.dart';
import 'package:druto/models/cart.dart';
import 'package:druto/models/hub.dart';
import 'package:druto/models/package.dart';
import 'package:druto/models/package_item.dart';
import 'package:druto/models/package_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/features/package/widgets/bundle_carousel.dart';
import 'package:druto/features/package/widgets/counter_bar.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

class BundleDetailsPage extends ConsumerWidget {
  final PackageLine packageLine;

  const BundleDetailsPage({
    super.key,
    required this.packageLine,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Package package = packageLine.package!;
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

    final int quantity = ref.watch(itemQuantityProvider);

    final hub = isLocationWithinAnyHub(
        hubs: hubs!,
        location: LatLng(position!.latitude, position.longitude))[0];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Bundle Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_bag,
              ),
            )
          ],
        ),
        body: AsyncValueWidget(
            value: ref.watch(isPackageInCartProvider(packageLine.id!)),
            data: (cart) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: AsyncValueWidget(
                    value: ref.watch(getPackageItemsProvider(
                        pckgId: package.id!, hId: hub.id!)),
                    data: (packageItems) {
                      final sum = packageItems.fold<double>(
                              0,
                              (value, element) =>
                                  value +
                                  (element.product_line!.price -
                                          element
                                              .product_line!.discountedPrice) *
                                      element.item_quantity) -
                          packageLine.discount;
                      final mainsum = packageItems.fold<double>(
                          0,
                          (value, element) =>
                              value + element.product_line!.price);
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BundleCarousel(pics: [
                              package.cover,
                              ...packageItems
                                  .map((e) => e.product_line!.products!.pic)
                                  .toList()
                            ]),
                            SizedBox(
                              height: context.height * 0.02,
                            ),
                            Text(
                              package.name,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: context.height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "৳$mainsum",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.lineThrough,
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                        decorationThickness: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      width: context.width * 0.02,
                                    ),
                                    Text(
                                      "৳$sum",
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor),
                                    ),
                                  ],
                                ),
                                cart != null
                                    ? const SizedBox.shrink()
                                    : const CounterBar(),
                              ],
                            ),
                            SizedBox(
                              height: context.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: context.width * 0.45,
                                    child: FloatingActionButton.extended(
                                      heroTag: "buy",
                                      backgroundColor: primaryColor,
                                      onPressed: () {},
                                      isExtended: true,
                                      label: Text(
                                        "Buy Now",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: context.f15),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Center(
                                    child: cart != null
                                        ? Container(
                                            width: 160,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: primaryColor,
                                                border: Border.all(
                                                    color: Colors.green,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    if (cart.quantity > 1) {
                                                      await ref
                                                          .read(
                                                              cartControllerProvider
                                                                  .notifier)
                                                          .decrementItem(
                                                              pckg_id: cart
                                                                  .pckgl_id!,
                                                              context: context);
                                                      ref.invalidate(
                                                          isPackageInCartProvider(
                                                              cart.pckgl_id!));
                                                    } else {
                                                      await ref
                                                          .read(
                                                              cartControllerProvider
                                                                  .notifier)
                                                          .removeItemFromCart(
                                                            context: context,
                                                            pckgId:
                                                                cart.pckgl_id!,
                                                          );
                                                      ref.invalidate(
                                                          isPackageInCartProvider(
                                                              cart.pckgl_id!));
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: const Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "${cart.quantity}",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if (cart.quantity <
                                                        packageLine.limit!) {
                                                      ref
                                                          .read(
                                                              cartControllerProvider
                                                                  .notifier)
                                                          .incrementItem(
                                                              pckgl_id: cart
                                                                  .pckgl_id!,
                                                              context: context);

                                                      ref.invalidate(
                                                          isPackageInCartProvider(
                                                              cart.pckgl_id!));
                                                    } else {
                                                      showSnackbar(
                                                        context: context,
                                                        inTop: true,
                                                        text:
                                                            "You can add ${packageLine.limit} ${packageLine.package!.name} per order",
                                                        leadingIcon: Icons.info,
                                                        backgroundColor:
                                                            Colors.green,
                                                      );

                                                      ref.invalidate(
                                                          isPackageInCartProvider(
                                                              cart.pckgl_id!));
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox(
                                            width: context.width * 0.45,
                                            child:
                                                FloatingActionButton.extended(
                                              heroTag: "cart",
                                              backgroundColor: primaryColor,
                                              onPressed: () async {
                                                await ref
                                                    .read(cartControllerProvider
                                                        .notifier)
                                                    .addToCart(
                                                      Cart(
                                                        id: package.id,
                                                        pckgl_id:
                                                            cart!.pckgl_id,
                                                        pckg_id: package.id,
                                                        quantity: quantity,
                                                      ),
                                                    );
                                              },
                                              isExtended: true,
                                              label: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.shopping_bag,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          context.width * 0.02),
                                                  Text(
                                                    "Add To Cart",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: context.f15),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: context.height * 0.02,
                            ),
                            Text(
                              "Bundle Items (${packageItems.length})",
                              style: TextStyle(
                                fontSize: context.f16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: packageItems.length,
                              itemBuilder: (context, index) {
                                final PackageItem packageItem =
                                    packageItems[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: ListTile(
                                    shape: Border.all(
                                        width: 0.2, color: Colors.black54),
                                    leading: Image.network(
                                      packageItem.product_line!.products!.pic,
                                      height: context.height * 0.042,
                                    ),
                                    title: Text(
                                      packageItem.product_line!.products!.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    trailing: Text(
                                      packageItem
                                          .product_line!.products!.weight,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: context.f15),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: context.height * 0.01,
                            ),
                            const ListTile()
                          ],
                        ),
                      );
                    },
                  ),
                )),
      ),
    );
  }
}
