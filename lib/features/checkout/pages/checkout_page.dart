import 'package:druto/core/constants/order_enums.dart';
import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/core/helpers/custom_snackbar.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/features/cart/controllers/cart_controller.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:druto/features/checkout/controllers/checkout_controller.dart';
import 'package:druto/features/home/pages/home_page.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/features/root/provider/location_provider.dart';
import 'package:druto/models/cart.dart';
import 'package:druto/models/order.dart';
import 'package:druto/models/order_product.dart';
import 'package:druto/models/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  TextEditingController houseController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final int deliveryCharge = 15;

  @override
  void dispose() {
    houseController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  int getDeliveryCharge(num totalPrice) {
    if (totalPrice > 149) {
      return 0;
    } else {
      return 15;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(checkoutControllerProvider);
    final currentPosition = ref.watch(getPositionProvider).valueOrNull;
    num getTotalItemPrice({
      required List<Cart> carts,
    }) {
      num sum = 0;
      for (var element in carts) {
        ref.watch(getProductLineByIdProvider(plId: element.pl_id!)).when(
              data: (data) {
                num itemPrice = data.discountedPrice != 0
                    ? (data.price - data.discountedPrice) * element.quantity
                    : data.price * element.quantity;
                sum += itemPrice; // Accumulate the sum here
              },
              error: (error, stackTrace) {},
              loading: () {},
            );
      }

      return sum;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: SingleChildScrollView(
          child: AsyncValueWidget(
        value: ref.watch(getpositionNameProvider(DoubleArg(
            lat: currentPosition!.latitude, lng: currentPosition.longitude))),
        data: (p0) => AsyncValueWidget(
            value: Supabase.instance.client.auth.currentUser != null
                ? ref.watch(getlocalCartItemsProvider)
                : ref.watch(getlocalCartItemsProvider),
            data: (carts) {
              final finalPrice = getTotalItemPrice(carts: carts) +
                  getDeliveryCharge(getTotalItemPrice(carts: carts));
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: houseController,
                            decoration: const InputDecoration(
                                filled: true,
                                hintText: "Your House No / Name",
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          SizedBox(
                            height: context.height * 0.01,
                          ),
                          TextField(
                            controller: phoneController,
                            decoration: const InputDecoration(
                                filled: true,
                                hintText: "Your Phone Number",
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          Text("Your Address :${p0[3].street}, ${p0[4].name}"),
                          const SizedBox(height: 10),
                          const Text(
                            "Review Products",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: context.height * 0.3,
                            child: ListView.separated(
                              itemCount: carts.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                      endIndent: 20,
                                      indent: 20,
                                      thickness: 0.6),
                              itemBuilder: (context, index) {
                                final Cart cart = carts[index];

                                return AsyncValueWidget(
                                  value: ref.watch(getProductLineByIdProvider(
                                      plId: cart.pl_id!)),
                                  data: (productLine) {
                                    final finalSum =
                                        productLine.discountedPrice == 0
                                            ? productLine.price
                                            : (productLine.price -
                                                productLine.discountedPrice);
                                    return Container(
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Image.network(
                                            productLine.products!.pic,
                                            height: 65,
                                            width: 65,
                                          ),
                                          SizedBox(
                                            width: context.width * 0.03,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                productLine.products!.name,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: context.height * 0.002,
                                              ),
                                              Text(
                                                productLine.products!.weight,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey[500]),
                                              ),
                                              SizedBox(
                                                height: context.height * 0.01,
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "৳ $finalSum x ${cart.quantity}",
                                                style: const TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 120,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total Price",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                                Text(
                                  "৳ ${getTotalItemPrice(carts: carts)}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Delivery Charge",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                                Text(
                                  "৳ ${getDeliveryCharge(getTotalItemPrice(carts: carts))}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Delivery Charge",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                                Text(
                                  "৳ $finalPrice",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: SizedBox(
                              width: context.width * 039,
                              child: FloatingActionButton.extended(
                                backgroundColor: Colors.green,
                                label: const Text(
                                  "Confirm Order",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                onPressed: () {
                                  OrderUserType usertype = Supabase.instance
                                              .client.auth.currentUser ==
                                          null
                                      ? OrderUserType.Guest
                                      : OrderUserType.User;
                                  if (phoneController.text.isNotEmpty &&
                                      houseController.text.isNotEmpty) {
                                    ref
                                        .read(
                                            checkoutControllerProvider.notifier)
                                        .placeOrder(
                                            order: UserOrder(
                                                order_user_type: usertype,
                                                total_amount: finalPrice,
                                                phone: phoneController.text,
                                                house: houseController.text),
                                            context: context,
                                            items: carts);
                                  } else {
                                    showSnackbar(
                                        context: context,
                                        text:
                                            "Please provide your phone and house name");
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
              );
            }),
      )),
    );
  }
}
