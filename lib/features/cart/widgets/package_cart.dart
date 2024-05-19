import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/core/utils/location_selection.dart';
import 'package:druto/features/cart/controllers/cart_controller.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/features/root/provider/location_provider.dart';
import 'package:druto/models/cart.dart';
import 'package:druto/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

class PackageCartItem extends ConsumerWidget {
  final Cart cart;
  const PackageCartItem({super.key, required this.cart});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(getPositionProvider).valueOrNull;
    final hubs = ref.watch(getHubsProvider).value;

    final hub = isLocationWithinAnyHub(
        hubs: hubs!,
        location: LatLng(position!.latitude, position.longitude))[0];

    return AsyncValueWidget(
      value: ref.watch(
          getPackagesByIdProvider(hubId: hub.id!, pckg_id: cart.pckg_id!)),
      data: (package) => AsyncValueWidget(
          value: ref.watch(getPackageItemsProvider(
              pckgId: package.package!.id!, hId: hub.id!)),
          data: (packageItems) {
            final sum = packageItems.fold<double>(
                0,
                (value, element) =>
                    value +
                    (element.product_line!.discountedPrice == 0
                        ? element.product_line!.price
                        : (element.product_line!.price -
                            element.product_line!.discountedPrice)));

            return GestureDetector(
              onTap: () =>
                  context.pushNamed(AppRoutes.bundle.name, extra: package),
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Image.network(
                      package.package!.cover,
                      height: context.height * 0.075,
                      width: context.width * 0.15,
                    ),
                    SizedBox(
                      width: context.width * 0.03,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          package.package!.name,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: context.height * 0.002,
                        ),
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (cart.quantity > 1) {
                                  ref
                                      .read(cartControllerProvider.notifier)
                                      .decrementItem(
                                          pckg_id: package.pckg_id,
                                          context: context);
                                } else {
                                  ref
                                      .read(cartControllerProvider.notifier)
                                      .removeItemFromCart(
                                          context: context,
                                          pckgId: cart.pckg_id);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Icon(Icons.remove),
                              ),
                            ),
                            SizedBox(width: context.width * 0.03),
                            Text(
                              "${cart.quantity}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: context.width * 0.03,
                            ),
                            GestureDetector(
                              onTap: () => ref
                                  .read(cartControllerProvider.notifier)
                                  .incrementItem(
                                      pckg_id: package.pckg_id,
                                      context: context),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Icon(
                                  Icons.add,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "৳ $sum",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: context.height * 0.015),
                        InkWell(
                          onTap: () {
                            ref
                                .read(cartControllerProvider.notifier)
                                .removeItemFromCart(
                                    context: context, pckgId: cart.pckg_id);
                          },
                          child: const Icon(
                            Icons.delete_outline,
                            size: 27,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
