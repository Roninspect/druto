import 'package:druto/features/orders/pages/guest_user_page.dart';
import 'package:druto/features/orders/pages/user_orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderPage extends ConsumerWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Supabase.instance.client.auth.currentUser != null
        ? const UserOrderPage()
        : const GuestOrderPage();
  }
}
