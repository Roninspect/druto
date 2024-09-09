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
      child: AsyncValueWidget(
        value: ref.watch(getCategoriesProvider),
        data: (categories) {
          int itemCount = categories.length;
          int crossAxisCount = 4; // Number of columns
          int rows = (itemCount / crossAxisCount).ceil(); // Total rows needed
          int totalItemCount =
              rows * crossAxisCount; // Total grid items including empty slots

          return GridView.builder(
            itemCount: totalItemCount,
            scrollDirection: Axis.vertical, // Changed to vertical scrolling
            shrinkWrap: true,
            primary: false,
            reverse: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisExtent: context.width * totalItemCount * 0.0166,
            ),
            itemBuilder: (context, index) {
              // Check if index is within the actual number of categories
              if (index < itemCount) {
                final ProductCategory category = categories[index];
                return Column(
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
                      child: Container(
                        height: context.height * 0.09,
                        width: context.width * 0.20,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            category.pic!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.height * 0.01,
                    ),
                    Text(
                      category.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
