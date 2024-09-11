import 'package:druto/features/home/widgets/list_banner.dart';
import 'package:druto/features/home/widgets/offer_slider.dart';
import 'package:druto/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/features/home/widgets/address_bar.dart';
import 'package:druto/features/home/widgets/category_listview.dart';
import 'package:druto/features/home/widgets/popular_package_listview.dart';
import 'package:druto/features/home/widgets/popular_products_listview.dart';
import 'package:druto/features/root/provider/location_provider.dart';
import 'package:druto/models/hub.dart';

final getpositionNameProvider =
    FutureProvider.family<List<Placemark>, DoubleArg>((ref, doubleArgs) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(
      doubleArgs.lat.toDouble(), doubleArgs.lng.toDouble());
  return placemarks;
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    final position = ref.watch(getPositionProvider).valueOrNull;
    return AsyncValueWidget(
      value: ref.watch(getHubsProvider),
      data: (p0) {
        final hub = isLocationWithinAnyHub(
            hubs: p0, location: LatLng(position!.latitude, position.longitude));

        return hub.isEmpty
            ? const Center(
                child: Text("Sorry , we're not available in your area!"))
            : Scaffold(
                appBar: AppBar(
                  toolbarHeight: 90,
                  centerTitle: false,
                  title: const AddressBar(),
                  actions: [
                    InkWell(
                      onTap: () => context.pushNamed(AppRoutes.search.name),
                      child: const Icon(
                        Ionicons.search,
                        size: 27,
                      ),
                    ),
                    SizedBox(width: context.wMdGap),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        MaterialCommunityIcons.heart_outline,
                        size: 26,
                      ),
                    ),
                    SizedBox(width: context.wMdGap),
                    InkWell(
                      onTap: () {},
                      child: const Badge(
                        child: Icon(
                          Ionicons.md_notifications_outline,
                          size: 27,
                        ),
                      ),
                    ),
                    SizedBox(width: context.wMdGap),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const OfferSlider(),
                        SizedBox(height: context.height * 0.01),
                        const Text(
                          "Shop by category",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: context.height * 0.01),
                        const CategoryListView(),
                        SizedBox(height: context.height * 0.02),
                        const PopularPackageListview(),
                        const PopularProductsListview(),
                        const ListBanner(position: 1),
                        const PopularProductsListview(),
                        const PopularProductsListview(),
                        const ListBanner(position: 2),
                        const PopularProductsListview(),
                        const PopularProductsListview(),
                        const ListBanner(position: 3),
                      ],
                    ),
                  ),
                ));
      },
    );
  }
}

class HomePage2 extends ConsumerWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home2"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Supabase.instance.client.auth.currentUser == null
              ? const Center(
                  child: Text("Plase register to continue"),
                )
              : const Text("Your List")
        ],
      ),
    );
  }
}

class DoubleArg {
  final num lat;
  final num lng;
  DoubleArg({
    required this.lat,
    required this.lng,
  });

  @override
  bool operator ==(covariant DoubleArg other) {
    if (identical(this, other)) return true;

    return other.lat == lat && other.lng == lng;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}

class DoubleArgs {
  int? plId;
  int? pckgId;
  DoubleArgs({
    this.plId,
    this.pckgId,
  });

  @override
  bool operator ==(covariant DoubleArgs other) {
    if (identical(this, other)) return true;

    return other.plId == plId && other.pckgId == pckgId;
  }

  @override
  int get hashCode => plId.hashCode ^ pckgId.hashCode;
}
