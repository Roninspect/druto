// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:druto/models/category.dart';
import 'package:druto/models/hub.dart';
import 'package:druto/models/package_item.dart';
import 'package:druto/models/package_line.dart';
import 'package:druto/models/product.dart';
import 'package:druto/models/product_line.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_repository.g.dart';

@Riverpod(keepAlive: true)
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository(client: Supabase.instance.client);
}

@Riverpod(keepAlive: true)
Future<List<ProductCategory>> getCategories(GetCategoriesRef ref) async {
  return ref.watch(homeRepositoryProvider).getCategories();
}

@Riverpod(keepAlive: true)
Future<List<Hub>> getHubs(GetHubsRef ref) async {
  return ref.watch(homeRepositoryProvider).getHubs();
}

@Riverpod(keepAlive: true)
Future<List<ProductLine>> getProductsByHub(
  GetProductsByHubRef ref, {
  required int? cid,
  required int hid,
}) async {
  return ref
      .watch(homeRepositoryProvider)
      .getProductByHub(centralId: cid!, hid: hid);
}

@Riverpod(keepAlive: true)
Future<List<PackageLine>> getPackagesByHubId(GetPackagesByHubIdRef ref,
    {required int hId}) async {
  return ref.watch(homeRepositoryProvider).getPackagesByHubId(hubId: hId);
}

@Riverpod(keepAlive: true)
Future<PackageLine> getPackagesById(GetPackagesByIdRef ref,
    {required int pckg_id, required int hubId}) async {
  return ref
      .watch(homeRepositoryProvider)
      .getPackagesById(pckg_id: pckg_id, hubId: hubId);
}

@Riverpod(keepAlive: true)
Future<List<PackageItem>> getPackageItems(GetPackageItemsRef ref,
    {required int pckgId, required int hId}) async {
  return ref
      .watch(homeRepositoryProvider)
      .getPackageItems(pckgId: pckgId, hid: hId);
}

@Riverpod(keepAlive: true)
Future<ProductLine> getProductLineById(GetProductLineByIdRef ref,
    {required int plId}) async {
  return ref.watch(homeRepositoryProvider).getProductLineById(plId: plId);
}

//** main Repository class */

class HomeRepository {
  final SupabaseClient client;
  HomeRepository({
    required this.client,
  });

  Future<List<ProductCategory>> getCategories() async {
    try {
      final res = await client
          .from('categories')
          .select('*')
          .order("priority", ascending: true);

      final List<ProductCategory> categories =
          res.map((e) => ProductCategory.fromMap(e)).toList();

      return categories;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Hub>> getHubs() async {
    try {
      final res = await client.from('hubs').select('*, polygons_points(*)');

      print(res);

      final List<Hub> hubs = res.map((e) => Hub.fromMap(e)).toList();

      return hubs;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductLine>> getProductByHub({
    required int centralId,
    required int hid,
  }) async {
    try {
      List<Map<String, dynamic>> res;

      res = await client
          .from("product_line")
          .select("*, products!inner(*)")
          .eq('c_id', centralId)
          .eq('h_id', hid)
          .order('bought', ascending: false)
          .limit(7);

      final List<ProductLine> products =
          res.map((e) => ProductLine.fromMap(e)).toList();

      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PackageLine>> getPackagesByHubId({
    required int hubId,
  }) async {
    try {
      final res = await client
          .from('package_line')
          .select('*, packages!inner(*)')
          .eq('h_id', hubId)
          .order('created_at', ascending: false);

      print("packages $res");

      List<PackageLine> packages =
          res.map((e) => PackageLine.fromMap(e)).toList();

      return packages;
    } catch (e) {
      rethrow;
    }
  }

  Future<PackageLine> getPackagesById({
    required int pckg_id,
    required int hubId,
  }) async {
    try {
      final res = await client
          .from('package_line')
          .select('*, packages!inner(*)')
          .eq('id', pckg_id)
          .eq('h_id', hubId)
          .order('created_at', ascending: false)
          .single();

      print(res);
      PackageLine packageLine = PackageLine.fromMap(res);

      return packageLine;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PackageItem>> getPackageItems({
    required int pckgId,
    required int hid,
  }) async {
    try {
      final res = await client
          .from('package_items')
          .select('*, product_line!inner(*, products(*))')
          .eq('pckg_id', pckgId)
          .eq('product_line.h_id', hid);

      List<PackageItem> packages =
          res.map((e) => PackageItem.fromMap(e)).toList();

      return packages;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductLine> getProductLineById({required int plId}) async {
    try {
      final res = await client
          .from('product_line')
          .select('*, products!inner(*)')
          .eq('id', plId)
          .single();

      final ProductLine productLine = ProductLine.fromMap(res);

      return productLine;
    } catch (e) {
      rethrow;
    }
  }
}
