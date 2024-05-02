// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final carouselIndexNotifierProvider =
//     NotifierProvider<CarouselIndexNotifier, int>(CarouselIndexNotifier.new);

// class CarouselIndexNotifier extends Notifier<int> {
//   @override
//   build() {
//     return 0;
//   }

//   void changeIndex(int index) {
//     state = index;
//   }

//   void changeIndexFromColorSelection(
//       {required List<ProductImage> productImages, required int colorId, }) {
//     final selectedIndex =
//         productImages.indexWhere((element) => element.color == colorId);

//     state = selectedIndex;
//   }
// }

final carouselIndexNotifierProvider = StateNotifierProvider.family<
    CarouselIndexNotifier, int, CarouselController>((ref, carouselController) {
  return CarouselIndexNotifier(
      carouselController: carouselController, ref: ref);
});

class CarouselIndexNotifier extends StateNotifier<int> {
  final CarouselController carouselController;
  final Ref ref;
  CarouselIndexNotifier({
    required this.carouselController,
    required this.ref,
  }) : super(0);
  void changeIndex(int index) {
    state = index;
  }

  void setnull() {
    carouselController.animateToPage(0);
    state = 0;
  }
}
