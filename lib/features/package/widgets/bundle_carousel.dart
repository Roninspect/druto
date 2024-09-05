import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:druto/core/extentions/mediquery_extention.dart';

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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: context.width * 0.7),
          child: CarouselView(
            itemExtent: context.height * 0.32,
            shrinkExtent: context.height * 0.25,
            children: widget.pics
                .map(
                  (e) => Image.network(
                    e,
                    height: context.height * 0.32,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
