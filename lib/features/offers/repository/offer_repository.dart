import 'package:druto/models/offer_item.dart';
import 'package:druto/models/offer_line.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'offer_repository.g.dart';

@Riverpod(keepAlive: true)
OfferRepository offerRepository(OfferRepositoryRef ref) {
  return OfferRepository(client: Supabase.instance.client);
}

@Riverpod(keepAlive: true)
Future<List<OfferLine>> getOffers(GetOffersRef ref, {required int h_id}) async {
  return ref.watch(offerRepositoryProvider).getOffers(h_id: h_id);
}

@Riverpod(keepAlive: true)
Future<List<OfferItem>> getOfferItems(GetOfferItemsRef ref,
    {required int ofl_id, required String path}) async {
  return ref
      .watch(offerRepositoryProvider)
      .getOfferItems(ofl_id: ofl_id, path: path);
}

class OfferRepository {
  final SupabaseClient client;
  OfferRepository({
    required this.client,
  });

  Future<List<OfferLine>> getOffers({required int h_id}) async {
    try {
      final res = await client
          .from("offer_lines")
          .select("*, offers(*)")
          .eq("h_id", h_id)
          .eq("is_active", true);

      final List<OfferLine> offers =
          res.map((e) => OfferLine.fromMap(e)).toList();

      return offers;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OfferItem>> getOfferItems(
      {required int ofl_id, required String path}) async {
    try {
      final res = await client
          .from("offer_items")
          .select("*, product_line(*, products(*)), offers(*)")
          .eq("ofl_id", ofl_id)
          .eq('product_line.is_active', true)
          .not('product_line', 'is', null)
          .eq('offers.path', path);

      print(res);

      final List<OfferItem> items =
          res.map((e) => OfferItem.fromMap(e)).toList();

      return items;
    } catch (e) {
      rethrow;
    }
  }
}
