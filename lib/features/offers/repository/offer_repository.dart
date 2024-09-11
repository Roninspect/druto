import 'package:druto/features/offers/providers/of_page_provider.dart';
import 'package:druto/models/double_args.dart';
import 'package:druto/models/offer_item.dart';
import 'package:druto/models/offer_line.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'offer_repository.g.dart';

@Riverpod(keepAlive: true)
OfferRepository offerRepository(OfferRepositoryRef ref) {
  return OfferRepository(client: Supabase.instance.client, ref: ref);
}

@Riverpod(keepAlive: true)
Future<List<OfferLine>> getOffers(GetOffersRef ref, {required int h_id}) async {
  return ref.watch(offerRepositoryProvider).getOffers(h_id: h_id);
}

@Riverpod(keepAlive: true)
Future<List<OfferLine>> getlistBanners(GetlistBannersRef ref,
    {required int h_id}) async {
  return ref.watch(offerRepositoryProvider).getlistBanners(h_id: h_id);
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
  final Ref ref;
  OfferRepository({required this.client, required this.ref});

  Future<List<OfferLine>> getOffers({required int h_id}) async {
    try {
      final res = await client
          .from("offer_lines")
          .select("*, offers!inner(*)")
          .eq("h_id", h_id)
          .eq("is_active", true)
          .eq("offers.for_list", false)
          .order("priority", ascending: true);

      final List<OfferLine> offers =
          res.map((e) => OfferLine.fromMap(e)).toList();

      return offers;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OfferLine>> getlistBanners({required int h_id}) async {
    try {
      final res = await client
          .from("offer_lines")
          .select("*, offers!inner(*)")
          .eq("h_id", h_id)
          .eq("is_active", true)
          .eq("offers.for_list", true)
          .order("list_priority", ascending: true);

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
      final pageNo = ref.watch(ofSelectedPageNoNotifierProvider);
      final range =
          DoubleArgsPaginate(start: pageNo! * 10, end: (pageNo * 10) + 10 - 1);
      final res = await client
          .from("offer_items")
          .select(
              "*, product_line!inner(*, products!inner(*)), offers!inner(*)")
          .eq("ofl_id", ofl_id)
          .eq('product_line.is_active', true)
          .eq('offers.path', path)
          .range(range.start, range.end)
          .limit(10);

      final List<OfferItem> items =
          res.map((e) => OfferItem.fromMap(e)).toList();

      return items;
    } catch (e) {
      rethrow;
    }
  }
}
