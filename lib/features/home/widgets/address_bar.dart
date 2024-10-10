// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:druto/features/home/pages/home_page.dart';
import 'package:druto/features/root/provider/location_provider.dart';
import 'package:druto/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:go_router/go_router.dart';

class AddressBar extends ConsumerWidget {
  const AddressBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(isPositionNotifierProvider);
    return ref
        .watch(getpositionNameProvider(
            DoubleArg(lat: position!.latitude, lng: position.longitude)))
        .when(
            data: (data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Delivery In",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: context.wSmGap),
                        const Text(
                          "15 Minutes",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 17,
                              color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.pushNamed(AppRoutes.address.name),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: context.midOverflow,
                          child: Text(
                            "${data[1].street},${data[3].street}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(155, 0, 0, 0)),
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: context.ism,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
            error: (error, stackTrace) => SizedBox(),
            loading: () => SizedBox());
  }
}
