import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressBar extends ConsumerWidget {
  const AddressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: context.midOverflow,
              child: const Text(
                "Kunjachaya R/A",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(155, 0, 0, 0)),
              ),
            ),
            InkWell(
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                size: context.ism,
              ),
            )
          ],
        ),
      ],
    );
  }
}
