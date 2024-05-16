import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterBar extends ConsumerWidget {
  const CounterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int quantity = ref.watch(itemQuantityProvider);
    return Row(
      children: [
        GestureDetector(
          onTap: () => ref.read(itemQuantityProvider.notifier).decrementCount(),
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
          "$quantity",
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: context.width * 0.03,
        ),
        GestureDetector(
          onTap: () => ref.read(itemQuantityProvider.notifier).incrementCount(),
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

class ItemQuantityNotifier extends StateNotifier<int> {
  ItemQuantityNotifier() : super(1);

  void incrementCount() {
    int newCount = state + 1;

    state = newCount;
  }

  void decrementCount() {
    int newCount;
    if (state > 1) {
      newCount = state - 1;
    } else {
      newCount = state;
    }

    state = newCount;
  }
}

final itemQuantityProvider =
    StateNotifierProvider<ItemQuantityNotifier, int>((ref) {
  return ItemQuantityNotifier();
});
