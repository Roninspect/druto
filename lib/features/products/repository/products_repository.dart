import 'package:druto/core/utils/location_selection.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/features/products/providers/page_provider.dart';
import 'package:druto/features/products/providers/selected_category.dart';
import 'package:druto/features/root/provider/location_provider.dart';
import 'package:druto/models/double_args.dart';
import 'package:druto/models/product_line.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'products_repository.g.dart';

@Riverpod(keepAlive: true)
ProductsRepository productsRepository(ProductsRepositoryRef ref) {
  return ProductsRepository(client: Supabase.instance.client);
}

@Riverpod(keepAlive: true)
Future<List<ProductLine>> getProductsByCategory(
  GetProductsByCategoryRef ref,
) async {
  return ref.watch(productsRepositoryProvider).getProductByCategory(ref: ref);
}

class ProductsRepository {
  final SupabaseClient client;
  ProductsRepository({
    required this.client,
  });

  Future<List<ProductLine>> getProductByCategory({required Ref ref}) async {
    try {
      final pageNo = ref.watch(selectedPageNoNotifierProvider);
      final range =
          DoubleArgsPaginate(start: pageNo! * 10, end: (pageNo * 10) + 10 - 1);

      final position = ref.read(getPositionProvider).valueOrNull;

      final hubs = ref.watch(getHubsProvider).valueOrNull;

      final hub = isLocationWithinAnyHub(
          hubs: hubs!,
          location: LatLng(position!.latitude, position.longitude))[0];

      final categoryId = ref.watch(selectedCategoryProvider);

      print(categoryId);

      List<Map<String, dynamic>> res;

      res = await client
          .from("product_line")
          .select("*, products!inner(*)")
          .eq('c_id', hub.cId)
          .eq('h_id', hub.id!)
          .eq('products.category', categoryId!)
          .order('bought', ascending: false)
          .range(range.start, range.end)
          .limit(10);

      final List<ProductLine> products =
          res.map((e) => ProductLine.fromMap(e)).toList();

      return products;
    } catch (e) {
      rethrow;
    }
  }
}
