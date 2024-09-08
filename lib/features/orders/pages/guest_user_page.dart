import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/helpers/custom_snackbar.dart';
import 'package:druto/core/theme/theme.dart';
import 'package:druto/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GuestOrderPage extends ConsumerStatefulWidget {
  const GuestOrderPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GuestOrderPageState();
}

class _GuestOrderPageState extends ConsumerState<GuestOrderPage> {
  final phoneController = TextEditingController();
  Text? errorText;
  bool gettingOrder = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Orders (Guest)"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Enter Phone Number to Track order",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: context.height * 0.01,
                  ),
                  SizedBox(
                    width: context.width * 0.7,
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: "017++++++++",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.height * 0.01,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    fixedSize:
                        Size(context.width * 0.6, context.height * 0.06)),
                onPressed: () {
                  if (phoneController.text.length < 11 ||
                      phoneController.text.length > 11) {
                    showSnackbar(
                        context: context,
                        inTop: true,
                        text: "Invalid Phone Number",
                        leadingIcon: Icons.warning_amber_outlined,
                        backgroundColor: Colors.amber);
                  } else {
                    context.pushNamed(AppRoutes.guestOrder.name,
                        pathParameters: {'phone': phoneController.text});
                  }
                },
                child: const Text(
                  "Track Order",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ));
  }
}
