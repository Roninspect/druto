import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:druto/features/products/providers/is_last_page.dart';
import 'package:druto/features/products/providers/page_provider.dart';
import 'package:druto/features/products/providers/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/features/home/widgets/product_card.dart';
import 'package:druto/models/hub.dart';
import 'package:druto/models/product_line.dart';
import 'package:go_router/go_router.dart';

class ProductsListByCategory extends ConsumerStatefulWidget {
  final String name;
  final int id;
  final Hub hub;
  const ProductsListByCategory({
    super.key,
    required this.name,
    required this.id,
    required this.hub,
  });

  @override
  ConsumerState<ProductsListByCategory> createState() =>
      _ProductsListByCategoryState();
}

class _ProductsListByCategoryState
    extends ConsumerState<ProductsListByCategory> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      loadMore();
    });
    super.initState();
  }

  void loadMore() async {
    final isLastPage = ref.read(isLastPageProvider);

    if (!isLastPage.isLastpage) {
      // Only load more if not on the last page
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        ref.read(productByCategoryProvider.notifier).loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(productByCategoryProvider).isLoading;
    final error = ref.watch(productByCategoryProvider).error;
    final data = ref.watch(productByCategoryProvider).valueOrNull;
    final postLoading = ref.watch(isLastPageProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                ref.invalidate(selectedPageNoNotifierProvider);
                ref.invalidate(isLastPageProvider);
                context.pop();
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(widget.name),
          toolbarHeight: context.height * 0.07,
          bottom:
              const PreferredSize(preferredSize: Size(0, 0), child: Divider()),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : error != null
                      ? Text(error.toString())
                      : data!.isEmpty
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
                                      itemCount: data.length,
                                      controller: scrollController,
                                      shrinkWrap: true,
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
                                            data[index];

                                        return AsyncValueWidget(
                                          value: ref.watch(isInCartProvider(
                                              productLine.id!)),
                                          data: (p0) => Padding(
                                              padding:
                                                  const EdgeInsets.all(7.0),
                                              child: AsyncValueWidget(
                                                value: ref.watch(
                                                    isInCartProvider(
                                                        productLine.id!)),
                                                data: (p0) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(7.0),
                                                  child: ProductCard(
                                                    productLine: productLine,
                                                    isInCart: p0 == null
                                                        ? false
                                                        : true,
                                                    cart: p0 ?? p0,
                                                  ),
                                                ),
                                              )),
                                        );
                                      },
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
                            )
            ],
          ),
        ),
      ),
    );
  }
}
