import 'package:druto/core/helpers/failure.dart';
import 'package:druto/core/helpers/typedefs.dart';
import 'package:druto/models/order.dart';
import 'package:druto/models/order_product.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'checkout_repository.g.dart';

@Riverpod(keepAlive: true)
CheckoutRepository checkoutRepository(CheckoutRepositoryRef ref) {
  return CheckoutRepository(client: Supabase.instance.client);
}

class CheckoutRepository {
  final SupabaseClient client;
  CheckoutRepository({
    required this.client,
  });

  FutureEither<int> placeBasicOrder(UserOrder order) async {
    try {
      final id = await client
          .from("orders")
          .insert(order.toMap())
          .select('id')
          .single();
      return right(id['id']);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid placeAllOrderProducts(List<OrderProducts> items) async {
    try {
      return right(await client
          .from("order_products")
          .insert(items.map((e) => e.toMap()).toList()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
