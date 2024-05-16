import 'dart:async';
import 'package:druto/models/order.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'order_repository.g.dart';

@Riverpod(keepAlive: true)
OrderRepository orderRepository(OrderRepositoryRef ref) {
  return OrderRepository(client: Supabase.instance.client);
}

@riverpod
Future<List<UserOrder>> getGuestOrders(GetGuestOrdersRef ref,
    {required String phone}) async {
  final timer = Timer(const Duration(minutes: 1), () {
    ref.invalidateSelf();
  });

  ref.onDispose(
    () {
      timer.cancel();
    },
  );

  return ref.watch(orderRepositoryProvider).getGuestOrders(phone: phone);
}

class OrderRepository {
  final SupabaseClient client;
  OrderRepository({
    required this.client,
  });

  Future<List<UserOrder>> getGuestOrders({required String phone}) async {
    try {
      final res = await client.from("orders").select().eq('phone', phone);

      final List<UserOrder> guestOrders =
          res.map((e) => UserOrder.fromMap(e)).toList();

      return guestOrders;
    } catch (e) {
      rethrow;
    }
  }
}
