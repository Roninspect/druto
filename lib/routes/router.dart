import 'package:druto/features/package/pages/bundle_details_page.dart';
import 'package:druto/features/product_details.dart/pages/product_details.dart';
import 'package:druto/features/root/pages/root_page.dart';
import 'package:druto/models/package.dart';
import 'package:druto/models/product.dart';
import 'package:druto/models/product_line.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'router.g.dart';

enum AppRoutes {
  root,
  bundle,
  product,
}

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const RootPage(),
        routes: [
          GoRoute(
            path: 'bundle',
            name: AppRoutes.bundle.name,
            builder: (context, state) => BundleDetailsPage(
              package: state.extra as Package,
            ),
          ),
          GoRoute(
            path: 'product',
            name: AppRoutes.product.name,
            builder: (context, state) {
              return ProductDetailsPage(
                  productLine: state.extra as ProductLine);
            },
          ),
        ],
      ),
    ],
  );
}