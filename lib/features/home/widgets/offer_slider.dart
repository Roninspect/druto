import 'package:druto/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:druto/features/offers/repository/offer_repository.dart';
import 'package:druto/features/offers/widgets/offerCard.dart';
import 'package:go_router/go_router.dart';

class OfferSlider extends ConsumerStatefulWidget {
  const OfferSlider({
    super.key,
  });

  @override
  ConsumerState<OfferSlider> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends ConsumerState<OfferSlider> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(getOffersProvider(h_id: 1)).when(
          data: (offerLines) => Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: CarouselView(
                  itemExtent: 350,
                  shrinkExtent: 350,
                  padding: const EdgeInsets.all(10.0),
                  onTap: (value) => context.pushNamed(AppRoutes.offers.name,
                      pathParameters: {"path": offerLines[value].offers.path},
                      extra: offerLines[value]),
                  children: offerLines
                      .map(
                        (offerLine) => OfferCard(offerLine: offerLine),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          error: (error, stackTrace) => const Center(
            child: Text("Some Error Happened"),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
