// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:druto/core/constants/order_enums.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/core/helpers/custom_snackbar.dart';
import 'package:druto/features/orders/repository/order_repository.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuestOrderListPage extends ConsumerStatefulWidget {
  final String phoneNumber;
  const GuestOrderListPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  ConsumerState<GuestOrderListPage> createState() => _GuestOrderListPageState();
}

class _GuestOrderListPageState extends ConsumerState<GuestOrderListPage> {
  int getStep(DeliveryStatus deliveryStatus) {
    if (deliveryStatus == DeliveryStatus.Pending) {
      return 0;
    } else if (deliveryStatus == DeliveryStatus.Processing) {
      return 1;
    } else if (deliveryStatus == DeliveryStatus.Delivering) {
      return 2;
    } else if (deliveryStatus == DeliveryStatus.Cancelled) {
      return 3;
    } else if (deliveryStatus == DeliveryStatus.Delivered) {
      return 4;
    } else {
      return 12;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Orders"),
          actions: [
            IconButton(
                onPressed: () {
                  showSnackbar(
                      context: context,
                      text: "Guest Order History Will be Removed after 24H",
                      subtitle: "Please Sign in to keep all records",
                      leadingIcon: Icons.warning_amber_outlined,
                      backgroundColor: Colors.amber);
                },
                icon: const Icon(Icons.info))
          ],
        ),
        body: AsyncValueWidget(
          value: ref.watch(getGuestOrdersProvider(phone: widget.phoneNumber)),
          data: (orders) => orders.isEmpty
              ? const Center(
                  child: Text("No Ongoing Order"),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: orders.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {},
                        tileColor: Colors.grey[100],
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order ID: #${order.id}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                            ),
                            Text(
                              "Total: ${order.total_amount}",
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Status:        ",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            EasyStepper(
                              activeStep: getStep(order.delivery_status!),
                              activeStepTextColor: Colors.black87,
                              finishedStepTextColor: Colors.black87,
                              internalPadding: 0,
                              showLoadingAnimation: false,
                              stepRadius: 12,
                              showStepBorder: false,
                              steps: [
                                EasyStep(
                                  customStep: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor:
                                          getStep(order.delivery_status!) >= 0
                                              ? Colors.amber
                                              : Colors.white,
                                    ),
                                  ),
                                  customTitle: const Text(
                                    'Pending',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                EasyStep(
                                  customStep: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor:
                                          getStep(order.delivery_status!) >= 1
                                              ? Colors.blue
                                              : Colors.white,
                                    ),
                                  ),
                                  customTitle: const Text(
                                    'Picking',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  topTitle: true,
                                ),
                                EasyStep(
                                  customStep: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor:
                                          getStep(order.delivery_status!) >= 2
                                              ? Colors.green
                                              : Colors.white,
                                    ),
                                  ),
                                  customTitle: const Text(
                                    'Delivering',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                order.delivery_status ==
                                        DeliveryStatus.Cancelled
                                    ? EasyStep(
                                        customStep: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: getStep(order
                                                        .delivery_status!) >=
                                                    3
                                                ? Colors.red
                                                : Colors.white,
                                          ),
                                        ),
                                        customTitle: const Text(
                                          'Cancelled',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        topTitle: true,
                                      )
                                    : EasyStep(
                                        customStep: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: getStep(order
                                                        .delivery_status!) >=
                                                    4
                                                ? Colors.green
                                                : Colors.white,
                                          ),
                                        ),
                                        customTitle: const Text(
                                          'Delivered',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        topTitle: true,
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ));
  }
}
