import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/features/products/providers/selected_category.dart';
import 'package:druto/features/root/provider/location_provider.dart';
import 'package:druto/models/category.dart';
import 'package:druto/models/hub.dart';
import 'package:druto/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

class CategoryListView extends ConsumerWidget {
  const CategoryListView({super.key});

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

    final hubs = ref.watch(getHubsProvider).valueOrNull;

    final hub = isLocationWithinAnyHub(
        hubs: hubs!,
        location: LatLng(position!.latitude, position.longitude))[0];

    return SizedBox(
        height: context.height * 0.13,
        child: AsyncValueWidget(
          value: ref.watch(getCategoriesProvider),
          data: (p0) => ListView.builder(
            itemCount: p0.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final ProductCategory category = p0[index];
              return Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(selectedCategoryProvider.notifier)
                            .selectedCategory(category.id!);
                        context.pushNamed(AppRoutes.category.name,
                            extra: hub,
                            pathParameters: {
                              'name': category.name,
                              "id": category.id.toString()
                            });
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(category.pic!),
                      ),
                    ),
                    SizedBox(
                      height: context.height * 0.01,
                    ),
                    Text(
                      category.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
