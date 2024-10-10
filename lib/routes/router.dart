import 'package:druto/features/address/pages/address_page.dart';
import 'package:druto/features/checkout/pages/checkout_page.dart';
import 'package:druto/features/offers/pages/offersPage.dart';
import 'package:druto/features/orders/pages/guest_orders.list.dart';
import 'package:druto/features/package/pages/bundle_details_page.dart';
import 'package:druto/features/product_details.dart/pages/product_details.dart';
import 'package:druto/features/products/pages/product_by_category_page.dart';
import 'package:druto/features/root/pages/root_page.dart';
import 'package:druto/features/search/pages/search_page.dart';
import 'package:druto/models/hub.dart';
import 'package:druto/models/offer_line.dart';
import 'package:druto/models/package_line.dart';
import 'package:druto/models/product_line.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'router.g.dart';

enum AppRoutes {
  root,
  bundle,
  product,
  checkout,
  category,
  guestOrder,
  search,
  offers,
  address,
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
              packageLine: state.extra as PackageLine,
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
          GoRoute(
            path: 'guestOrder/:phone',
            name: AppRoutes.guestOrder.name,
            builder: (context, state) =>
                GuestOrderListPage(phoneNumber: state.pathParameters['phone']!),
          ),
          GoRoute(
            path: 'search',
            name: AppRoutes.search.name,
            builder: (context, state) => const SearchPage(),
          ),
          GoRoute(
            path: 'offers/:path',
            name: AppRoutes.offers.name,
            builder: (context, state) => OffersPage(
              offerLine: state.extra as OfferLine,
              path: state.pathParameters["path"]!,
            ),
          ),
          GoRoute(
            path: 'address',
            name: AppRoutes.address.name,
            builder: (context, state) => const AddressPage(),
          )
        ],
      ),
    ],
  );
}
