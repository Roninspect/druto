import 'package:druto/features/checkout/pages/checkout_page.dart';
import 'package:druto/features/home/pages/home_page.dart';
import 'package:druto/features/package/pages/bundle_details_page.dart';
import 'package:druto/features/product_details.dart/pages/product_details.dart';
import 'package:druto/features/products/pages/product_by_category_page.dart';
import 'package:druto/features/root/pages/root_page.dart';
import 'package:druto/models/category.dart';
import 'package:druto/models/hub.dart';
import 'package:druto/models/package.dart';
import 'package:druto/models/product_line.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'router.g.dart';

enum AppRoutes { root, bundle, product, checkout, category }

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
          GoRoute(
            path: 'checkout',
            name: AppRoutes.checkout.name,
            builder: (context, state) {
              return const CheckoutPage();
            },
          ),
          GoRoute(
            path: 'category/:name/:id',
            name: AppRoutes.category.name,
            builder: (context, state) {
              return ProductsListByCategory(
                name: state.pathParameters['name']!,
                id: int.parse(state.pathParameters['id']!),
                hub: state.extra as Hub,
              );
            },
          ),
        ],
      ),
    ],
  );
}
