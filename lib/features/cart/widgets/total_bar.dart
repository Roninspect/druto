import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/features/config/config_provider.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/features/root/provider/location_provider.dart';
import 'package:druto/models/cart.dart';
import 'package:druto/models/hub.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

class TotalBar extends ConsumerWidget {
  final List<Cart> carts;
  const TotalBar(this.carts, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(getPositionProvider).valueOrNull;

    final hubs = ref.watch(getHubsProvider).value!;

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
        hubs: hubs,
        location: LatLng(position!.latitude, position.longitude))[0];

    num getTotalItemPrice({required List<Cart> carts, required int hubId}) {
      num sum = 0;
      for (var cart in carts) {
        cart.pl_id == null
            ? ref
                .watch(
                    getPackageItemsProvider(pckgId: cart.pckg_id!, hId: hubId))
                .when(
                data: (packageItems) {
                  double packsum = 0;
                  ref
                      .watch(getPackagesByIdProvider(
                          hubId: hubId, pckg_id: cart.pckgl_id!))
                      .when(
                        data: (pckgLine) {
                          packsum = (packageItems.fold<double>(
                                      0,
                                      (value, element) =>
                                          value +
                                          (element.product_line!.price -
                                                  element.product_line!
                                                      .discountedPrice) *
                                              element.item_quantity) -
                                  pckgLine.discount) *
                              cart.quantity;
                        },
                        error: (error, stackTrace) => packsum = 0,
                        loading: () => packsum = 0,
                      );

                  sum += packsum;
                },
                error: (error, stackTrace) {
                  return 0;
                },
                loading: () {
                  return 0;
                },
              )
            : ref.watch(getProductLineByIdProvider(plId: cart.pl_id!)).when(
                data: (data) {
                  num itemPrice =
                      (data.price - data.discountedPrice) * cart.quantity;

                  sum += itemPrice; // Accumulate the sum here
                },
                error: (error, stackTrace) {
                  return 0;
                },
                loading: () {
                  return 0;
                },
              );
      }

      return sum;
    }

    int getDeliveryCharge(num totalPrice) {
      if (totalPrice > 149) {
        return 0;
      } else {
        return 15;
      }
    }

    return AsyncValueWidget(
      value: ref.watch(getConfigsProvider),
      data: (configs) {
        final freeDeliveryCondition =
            getTotalItemPrice(carts: carts, hubId: hub.id!) >
                    configs.min_delivery
                ? 0
                : configs.min_delivery -
                    getTotalItemPrice(carts: carts, hubId: hub.id!);
        return Container(
          color: Colors.grey[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Padding(
              //   padding: EdgeInsets.symmetric(vertical: 8.0),
              //   child: Text(
              //     "Add Coupon",
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              // ),
              // SizedBox(height: context.height * 0.01),
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     SizedBox(
              //         width: context.width * 0.62,
              //         height: context.height * 0.068,
              //         child: const TextField(
              //           decoration: InputDecoration(
              //             hintText: "Add Voucher Code",
              //             border: OutlineInputBorder(),
              //             enabledBorder: OutlineInputBorder(
              //               borderSide: BorderSide(width: 0.2),
              //             ),
              //           ),
              //         )),
              //     SizedBox(width: context.width * 0.03),
              //     ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //           backgroundColor:
              //               Supabase.instance.client.auth.currentUser != null
              //                   ? Colors.green
              //                   : Colors.grey,
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(10)),
              //           fixedSize:
              //               Size(context.width * 0.3, context.height * 0.055)),
              //       onPressed: () {
              //         if (Supabase.instance.client.auth.currentUser == null) {
              //           showSnackbar(
              //               context: context,
              //               leadingIcon: Icons.warning_amber,
              //               backgroundColor: Colors.red,
              //               text: "Please Sign In to Use Coupons",
              //               subtitle: "Click here to Sign In");
              //         }
              //       },
              //       child: const Text(
              //         "Apply",
              //         style: TextStyle(fontSize: 18, color: Colors.white),
              //       ),
              //     )
              //   ],
              // ),
              SizedBox(height: context.height * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Price",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                    Text(
                      "৳ ${getTotalItemPrice(carts: carts, hubId: hub.id!)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Delivery Charge",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                    Text(
                      getDeliveryCharge(getTotalItemPrice(
                                  carts: carts, hubId: hub.id!)) ==
                              0
                          ? "৳15"
                          : "৳${carts.isEmpty ? 0 : getDeliveryCharge(getTotalItemPrice(carts: carts, hubId: hub.id!))}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: freeDeliveryCondition == 0
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationThickness: 3,
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.height * 0.01),
              Container(
                padding: const EdgeInsets.all(5),
                height: context.height * 0.05,
                decoration: BoxDecoration(
                    color: freeDeliveryCondition == 0
                        ? Colors.green[200]
                        : Colors.blue[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    freeDeliveryCondition == 0
                        ? "Your Delivery Charge is Free"
                        : "Shop for ৳$freeDeliveryCondition more to get free delivery",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
