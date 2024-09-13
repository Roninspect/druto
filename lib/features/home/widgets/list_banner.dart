// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:druto/features/offers/repository/offer_repository.dart';
import 'package:druto/routes/router.dart';

class ListBanner extends ConsumerWidget {
  final int position;

  const ListBanner({
    super.key,
    required this.position,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(getlistBannersProvider(h_id: 1)).isLoading;
    final banners = ref.watch(getlistBannersProvider(h_id: 1)).valueOrNull;
    final error = ref.watch(getlistBannersProvider(h_id: 1)).hasError;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : banners!.length < position || error
            ? const SizedBox()
            : GestureDetector(
                onTap: () => banners[position - 1].offers.hasItems
                    ? context.pushNamed(AppRoutes.offers.name,
                        pathParameters: {
                          "path": banners[position - 1].offers.path!
                        },
                        extra: banners[position - 1])
                    : () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: 190,
                    width: context.width * 0.95,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        banners[position - 1].offers.banner,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              );
  }
}
