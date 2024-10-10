import 'package:druto/core/constants/env.dart';
import 'package:druto/features/root/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final aappstartupProvider = FutureProvider<Supabase>((ref) async {
  final res = await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.anonKey,
  );

  return res;
});

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key, required this.onLoaded});
  final WidgetBuilder onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(aappstartupProvider).when(
          data: (data) {
            return onLoaded(context);
          },
          loading: () => const AppStartupLoadingWidget(
              loadingCause: "Getting data from server"),
          error: (e, stk) {
            return AppStartupErrorWidget(
              message: stk.toString(),
              onRetry: () {},
            );
          },
        );
  }
}

class AppStartupLoadingWidget extends StatelessWidget {
  final String loadingCause;
  const AppStartupLoadingWidget({super.key, required this.loadingCause});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: CircularProgressIndicator(),
            ),
            Center(
              child: Text(loadingCause),
            )
          ],
        ),
      ),
    );
  }
}

class AppStartupErrorWidget extends StatelessWidget {
  const AppStartupErrorWidget(
      {super.key, required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    print(message);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onRetry,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
