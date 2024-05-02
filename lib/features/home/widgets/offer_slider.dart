import 'package:carousel_slider/carousel_slider.dart';
import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/features/home/providers/slider_provider.dart';
import 'package:druto/features/home/widgets/banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OfferSlider extends ConsumerStatefulWidget {
  const OfferSlider({
    super.key,
  });

  @override
  ConsumerState<OfferSlider> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends ConsumerState<OfferSlider> {
  late CarouselController carouselController;

  @override
  void initState() {
    super.initState();
    carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    final carouselIndex =
        ref.watch(carouselIndexNotifierProvider(carouselController));

    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: carouselController,
          itemCount: 5,
          itemBuilder: (context, index, realIndex) {
            return const Column(
              children: [
                OfferBanner(),
              ],
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            onPageChanged: (index, reason) {
              ref
                  .read(carouselIndexNotifierProvider(carouselController)
                      .notifier)
                  .changeIndex(index);
            },
            height: context.height * 0.225,
          ),
        ),
        AnimatedSmoothIndicator(
          effect: const ColorTransitionEffect(
            activeDotColor: primaryColor,
            dotHeight: 11,
            dotWidth: 11,
          ),
          activeIndex: carouselIndex,
          count: 5,
          onDotClicked: (index) {
            ref
                .read(
                    carouselIndexNotifierProvider(carouselController).notifier)
                .changeIndex(index);
            carouselController.animateToPage(index);
          },
        )
      ],
    );
  }
}
