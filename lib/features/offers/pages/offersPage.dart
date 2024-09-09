// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:druto/features/home/widgets/product_card.dart';
import 'package:druto/features/offers/providers/of_is_lasr_page.dart';
import 'package:druto/features/offers/providers/of_item_list.dart';
import 'package:druto/models/offer_item.dart';
import 'package:druto/models/product_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:druto/features/offers/repository/offer_repository.dart';
import 'package:druto/models/offer_line.dart';

class OffersPage extends ConsumerStatefulWidget {
  final OfferLine offerLine;
  final String path;
  const OffersPage({
    super.key,
    required this.offerLine,
    required this.path,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OffersPageState();
}

class _OffersPageState extends ConsumerState<OffersPage> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      loadMore();
    });
    super.initState();
  }

  void loadMore() async {
    final isLastPage = ref.read(ofIsLastPageProvider);

    if (!isLastPage.isLastpage) {
      // Only load more if not on the last page
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        ref
            .read(offerItemsListProvider(
                    ofl_id: widget.offerLine.id, path: widget.path)
                .notifier)
            .loadMore(ofl_id: widget.offerLine.id, path: widget.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(offerItemsListProvider(
            ofl_id: widget.offerLine.id, path: widget.path))
        .isLoading;
    final error = ref
        .watch(offerItemsListProvider(
            ofl_id: widget.offerLine.id, path: widget.path))
        .error;
    final items = ref
        .watch(offerItemsListProvider(
            ofl_id: widget.offerLine.id, path: widget.path))
        .valueOrNull;
    final postLoading = ref.watch(ofIsLastPageProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.offerLine.offers.name),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200,
              width: 600,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.offerLine.offers.banner,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : error != null
                  ? Text(error.toString())
                  : items!.isEmpty
                      ? const Column(
                          children: [
                            Center(
                              child: Text("No product"),
                            )
                          ],
                        )
                      : Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: GridView.builder(
                                  itemCount: items.length,
                                  shrinkWrap: true,
                                  controller: scrollController,
                                  physics: postLoading.isLoading
                                      ? const NeverScrollableScrollPhysics()
                                      : const AlwaysScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: context.height * 0.31,
                                  ),
                                  itemBuilder: (context, index) {
                                    final ProductLine productLine =
                                        items[index].product_line;

                                    return AsyncValueWidget(
                                      value: ref.watch(
                                          isInCartProvider(productLine.id!)),
                                      data: (p0) => Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: AsyncValueWidget(
                                            value: ref.watch(isInCartProvider(
                                                productLine.id!)),
                                            data: (p0) => Padding(
                                              padding:
                                                  const EdgeInsets.all(7.0),
                                              child: ProductCard(
                                                productLine: productLine,
                                                isInCart:
                                                    p0 == null ? false : true,
                                                cart: p0 ?? p0,
                                              ),
                                            ),
                                          )),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
          SizedBox(
            height: postLoading.isLoading ? 20 : 0,
          ),
          if (postLoading.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
