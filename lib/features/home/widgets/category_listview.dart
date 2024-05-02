import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CategoryListView extends ConsumerWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    CircleAvatar(
                      backgroundColor: primaryColor,
                      radius: context.height * 0.035,
                      child: const Icon(
                        FontAwesome5Solid.carrot,
                        color: Colors.white,
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
