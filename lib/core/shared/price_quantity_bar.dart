import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/features/package/widgets/counter_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceQuantitybar extends ConsumerWidget {
  const PriceQuantitybar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "\$50",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationThickness: 2,
                    ),
                  ),
                  SizedBox(
                    width: context.width * 0.02,
                  ),
                  const Text(
                    "\$40",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                ],
              ),
              const CounterBar(),
            ],
          ),
        ],
      ),
    );
  }
}
