// import 'package:druto/features/products/providers/page_provider.dart';
// import 'package:druto/models/double_args.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final fdWonrangeNotifierProvider =
//     NotifierProvider<RangeNotifier, DoubleArgsPaginate>(RangeNotifier.new);

// class RangeNotifier extends Notifier<DoubleArgsPaginate> {
//   @override
//   build() {
//     return DoubleArgsPaginate(start: 0, end: 9);
//   }

//   void updateRange() {
//     final selectedPage = ref.watch(selectedPageNoProvider);
//     state = DoubleArgsPaginate(
//         start: selectedPage * 10, end: (selectedPage * 10) + 10 - 1);
//   }
// }
