// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final localCartProvider = Provider<LocalCartRepository>((ref) {
//   return LocalCartRepository();
// });

// final getlocalCartItemsProvider = FutureProvider<List<Cart>>((ref) async {
//   return ref.watch(localCartProvider).getLocalCartItems();
// });

// class LocalCartRepository {
//   Future<void> addToLocalCart({required Cart localIds}) async {
//     try {
//       final sharefPref = await SharedPreferences.getInstance();

//       final cartItemsStrings = sharefPref.getString("cart");

//       final List<dynamic> cartList = jsonDecode(cartItemsStrings!);

//       final List<Cart> convertedList =
//           cartList.map((e) => Cart.fromJson(e)).toList();

//       final existingItemIndex =
//           convertedList.indexWhere((item) => item == localIds);

//       if (existingItemIndex != -1) {
//         Cart existingItem = convertedList[existingItemIndex];
//         print("Existing item found: ${convertedList[existingItemIndex]}");

//         convertedList[existingItemIndex] =
//             existingItem.copyWith(quantity: existingItem.quantity + 1);
//       } else {
//         convertedList.add(localIds);
//       }

//       await sharefPref.setString('cart', jsonEncode(convertedList));
//     } catch (e, stk) {
//       print(stk);
//       print(e);
//       rethrow;
//     }
//   }

//   Future<List<Cart>> getLocalCartItems() async {
//     try {
//       final sharefPref = await SharedPreferences.getInstance();

//       final cartItemsStrings = sharefPref.getString("cart");

//       final List<dynamic> cartList = jsonDecode(cartItemsStrings!);

//       final List<Cart> convertedList =
//           cartList.map((e) => Cart.fromJson(e)).toList();
//       return convertedList;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
