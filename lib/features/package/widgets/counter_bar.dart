import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterBar extends ConsumerStatefulWidget {
  const CounterBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CounterBarState();
}

class _CounterBarState extends ConsumerState<CounterBar> {
  int count = 1;

  void handleIncrementCount() {
    setState(() {
      count++;
    });
  }

  void handleDecrementCount() {
    setState(() {
      if (count > 1) {
        count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => handleDecrementCount(),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.remove),
          ),
        ),
        SizedBox(
          width: context.width * 0.03,
        ),
        Text(
          "$count",
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: context.width * 0.03,
        ),
        GestureDetector(
          onTap: () => handleIncrementCount(),
          child: Container(
            padding: const EdgeInsets.all(5),
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
    );
  }
}
