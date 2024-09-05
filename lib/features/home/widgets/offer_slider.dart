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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: CarouselView(
            itemExtent: 400,
            padding: const EdgeInsets.all(10.0),
            children: List.generate(
              4,
              (index) => const OfferBanner(),
            ),
          ),
        )
      ],
    );
  }
}
