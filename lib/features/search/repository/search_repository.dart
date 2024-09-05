import 'package:druto/models/product_line.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'search_repository.g.dart';

@Riverpod(keepAlive: true)
SearchRepository searchRepository(SearchRepositoryRef ref) {
  return SearchRepository(client: Supabase.instance.client);
}

@riverpod
Future<List<ProductLine>> searchProducts(SearchProductsRef ref,
    {required String query, required int hubId}) {
  return ref
      .watch(searchRepositoryProvider)
      .searchProducts(query: query, hubId: hubId);
}

class SearchRepository {
  final SupabaseClient client;
  SearchRepository({
    required this.client,
  });

  Future<List<ProductLine>> searchProducts(
      {required String query, required int hubId}) async {
    try {
      final res = await client
          .from('product_line')
          .select("*, products!inner(*)")
          .eq('h_id', hubId)
          .eq('is_active', true)
          .ilike('products.search_terms', "%$query%")
          .order('bought', ascending: false);

      final List<ProductLine> products =
          res.map((e) => ProductLine.fromMap(e)).toList();
      return products;
    } catch (e) {
      rethrow;
    }
  }
}
