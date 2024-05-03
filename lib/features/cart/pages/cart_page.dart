import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/core/helpers/custom_snackbar.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/features/cart/controllers/cart_controller.dart';
import 'package:druto/features/cart/repository/local/local_repository.dart';
import 'package:druto/features/home/repository/home_repository.dart';
import 'package:druto/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    num getTotalItemPrice({
      required List<Cart> carts,
    }) {
      num sum = 0;
      for (var element in carts) {
        ref.watch(getProductLineByIdProvider(plId: element.pl_id)).when(
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
        title: const Text("My Cart"),
        bottom:
            const PreferredSize(preferredSize: Size(0, 0), child: Divider()),
      ),
      body: AsyncValueWidget(
        value: Supabase.instance.client.auth.currentUser != null
            ? ref.watch(getlocalCartItemsProvider)
            : ref.watch(getlocalCartItemsProvider),
        data: (carts) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.height * 0.46,
                    child: ListView.separated(
                      itemCount: carts.length,
                      separatorBuilder: (context, index) => const Divider(
                          endIndent: 20, indent: 20, thickness: 0.6),
                      itemBuilder: (context, index) {
                        final Cart cart = carts[index];

                        return AsyncValueWidget(
                          value: ref.watch(
                              getProductLineByIdProvider(plId: cart.pl_id)),
                          data: (productLine) {
                            final finalSum = productLine.discountedPrice == 0
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
                                            fontWeight: FontWeight.w600),
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
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () => ref
                                                .read(cartControllerProvider
                                                    .notifier)
                                                .decrementItem(
                                                    plId: cart.pl_id,
                                                    context: context),
                                            child: Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  border:
                                                      Border.all(width: 0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: const Icon(Icons.remove),
                                            ),
                                          ),
                                          SizedBox(
                                            width: context.width * 0.03,
                                          ),
                                          Text(
                                            "${cart.quantity}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: context.width * 0.03,
                                          ),
                                          GestureDetector(
                                            onTap: () => ref
                                                .read(cartControllerProvider
                                                    .notifier)
                                                .incrementItem(
                                                    plId: cart.pl_id,
                                                    context: context),
                                            child: Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  border:
                                                      Border.all(width: 0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: const Icon(
                                                Icons.add,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            size: 27,
                                          )),
                                      Text(
                                        "৳ $finalSum x ${cart.quantity}",
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600),
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
                  SizedBox(height: context.height * 0.01),
                  Container(
                    color: Colors.grey[100],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Add Coupon",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: context.height * 0.01),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                                width: 250,
                                height: 50,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Add Voucher Code",
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0.2),
                                    ),
                                  ),
                                )),
                            SizedBox(width: context.width * 0.03),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Supabase.instance.client.auth
                                              .currentUser !=
                                          null
                                      ? Colors.green
                                      : Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  fixedSize: Size(context.width * 0.3,
                                      context.height * 0.055)),
                              onPressed: () {
                                if (Supabase.instance.client.auth.currentUser ==
                                    null) {
                                  showSnackbar(
                                      context: context,
                                      text: "Please Sign In To Use Coupon");
                                }
                              },
                              child: const Text(
                                "Apply",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: context.height * 0.01),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Price",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              Text(
                                "৳ ${getTotalItemPrice(carts: carts)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
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
                                "Shipping Charge",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              Text(
                                "৳ ${getTotalItemPrice(carts: carts)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Discount",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 17),
                              ),
                              Text(
                                "৳ ${getTotalItemPrice(carts: carts)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ],
                          ),
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
                          "Checkout",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
