// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/features/home/widgets/address_bar.dart';
import 'package:druto/features/home/widgets/category_listview.dart';
import 'package:druto/features/home/widgets/offer_slider.dart';
import 'package:druto/features/home/widgets/popular_package_listview.dart';
import 'package:druto/features/home/widgets/popular_products_listview.dart';
import 'package:druto/features/root/provider/location_provider.dart';
import 'package:druto/models/hub.dart';

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
                      onTap: () {},
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
                      children: [
                        // offer carousel slider
                        const OfferSlider(),
                        SizedBox(height: context.height * 0.02),
                        // Category List Builder

                        const CategoryListView(),
                        const PopularPackageListview(),
                        const PopularProductsListview()
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
