import 'package:druto/core/extentions/mediquery_extention.dart';
import 'package:druto/core/helpers/async_value_helper.dart';
import 'package:druto/core/helpers/custom_snackbar.dart';
import 'package:druto/features/home/pages/home_page.dart';
import 'package:druto/features/root/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddressPage extends ConsumerWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(isPositionNotifierProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Address Book"),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Supabase.instance.client.auth.currentUser == null
                  ? showSnackbar(
                      context: context,
                      text: "Please Log In to save more addresses",
                      leadingIcon: Icons.warning_amber_rounded,
                      backgroundColor: Colors.red)
                  : null;
            },
            label: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.add_location_alt_sharp,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Add New Address",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )
              ],
            )),
        body: AsyncValueWidget(
          value: ref.watch(getpositionNameProvider(
              DoubleArg(lat: position!.latitude, lng: position.longitude))),
          data: (placemark) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Supabase.instance.client.auth.currentUser == null
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: context.width,
                      child: Card(
                          elevation: 2,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Current",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  "${placemark[2].street}, ${placemark[3].street},",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: context.f15),
                                ),
                              ],
                            ),
                          )),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ));
  }
}
