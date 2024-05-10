import 'package:druto/features/products/providers/is_last_page.dart';
import 'package:druto/features/products/providers/page_provider.dart';
import 'package:druto/features/products/providers/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/features/home/widgets/product_card.dart';
import 'package:druto/features/products/repository/products_repository.dart';
import 'package:druto/models/hub.dart';
import 'package:druto/models/product_line.dart';

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
          title: Text(widget.name),
          toolbarHeight: 60,
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
                      : Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: GridView.builder(
                                  itemCount: data!.length,
                                  controller: scrollController,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5,
                                  ),
                                  itemBuilder: (context, index) {
                                    final ProductLine productLine = data[index];

                                    return Column(
                                      children: [
                                        ProductCard(productLine: productLine),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              if (postLoading.isLoading)
                                const Center(child: CircularProgressIndicator())
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
