import 'dart:convert';
import 'package:druto/app_startup.dart';
import 'package:druto/core/constants/env.dart';
import 'package:druto/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();

  // bool isFirstOpen = prefs.getBool('firstOpen') ?? true;

  // if (isFirstOpen) {
  //   // Initialize default value only on first open
  //   prefs.setString('cart', jsonEncode(<Cart>[]));
  //   prefs.setBool('firstOpen', false);
  // }

  runApp(
    ProviderScope(
      child: AppStartupWidget(onLoaded: (context) => const MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      routerConfig: router,
    );
  }
}
