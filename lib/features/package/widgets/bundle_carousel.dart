// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/features/home/widgets/banner.dart';
import 'package:druto/features/package/providers/slider_provider.dart';

class BundleCarousel extends ConsumerStatefulWidget {
  final List<String> pics;
  const BundleCarousel({
    super.key,
    required this.pics,
  });

  @override
  ConsumerState<BundleCarousel> createState() => _BundleCarouselState();
}

class _BundleCarouselState extends ConsumerState<BundleCarousel> {
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
          itemCount: widget.pics.length,
          itemBuilder: (context, index, realIndex) {
            final pic = widget.pics[index];
            return Column(
              children: [
                Image.network(
                  pic,
                  height: 300,
                )
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
            height: context.height * 0.35,
          ),
        ),
        AnimatedSmoothIndicator(
          effect: const CustomizableEffect(
              dotDecoration: DotDecoration(
                color: Colors.black54,
                width: 30,
                height: 4,
              ),
              activeDotDecoration: DotDecoration(
                color: primaryColor,
                width: 30,
                height: 4,
              )),
          activeIndex: carouselIndex,
          count: widget.pics.length,
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
