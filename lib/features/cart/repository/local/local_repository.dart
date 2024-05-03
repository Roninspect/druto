// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:druto/core/helpers/failure.dart';
import 'package:druto/core/helpers/typedefs.dart';
import 'package:druto/models/cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localCartProvider = Provider<LocalCartRepository>((ref) {
  return LocalCartRepository();
});

final getlocalCartItemsProvider = FutureProvider<List<Cart>>((ref) async {
  return ref.watch(localCartProvider).getLocalCartItems();
});

class LocalCartRepository {
  Future<void> addToLocalCart({required Cart localIds}) async {
    try {
      final sharefPref = await SharedPreferences.getInstance();

      final cartItemsStrings = sharefPref.getString("cart");

      final List<dynamic> cartList = jsonDecode(cartItemsStrings!);

      final List<Cart> convertedList =
          cartList.map((e) => Cart.fromJson(e)).toList();

      final existingItemIndex =
          convertedList.indexWhere((item) => item.pl_id == localIds.pl_id);

      if (existingItemIndex != -1) {
        Cart existingItem = convertedList[existingItemIndex];
        print("Existing item found: ${convertedList[existingItemIndex]}");

        convertedList[existingItemIndex] =
            existingItem.copyWith(quantity: existingItem.quantity + 1);
      } else {
        convertedList.add(localIds);
      }

      print(convertedList);

      await sharefPref.setString('cart', jsonEncode(convertedList));
    } catch (e, stk) {
      print(stk);
      print(e);
      rethrow;
    }
  }

  Future<List<Cart>> getLocalCartItems() async {
    try {
      final sharefPref = await SharedPreferences.getInstance();

      final cartItemsStrings = sharefPref.getString("cart");

      final List<dynamic> cartList = jsonDecode(cartItemsStrings!);

      final List<Cart> convertedList =
          cartList.map((e) => Cart.fromJson(e)).toList();
      return convertedList;
    } catch (e) {
      rethrow;
    }
  }

  FutureVoid incrementItem({required int plId}) async {
    try {
      final sharefPref = await SharedPreferences.getInstance();

      final cartItemsStrings = sharefPref.getString("cart");

      final List<dynamic> cartList = jsonDecode(cartItemsStrings!);

      final List<Cart> convertedList =
          cartList.map((e) => Cart.fromJson(e)).toList();

      final itemToBeIncemented =
          convertedList.indexWhere((item) => item.pl_id == plId);

      Cart existingItem = convertedList[itemToBeIncemented];

      convertedList[itemToBeIncemented] =
          existingItem.copyWith(quantity: existingItem.quantity + 1);

      return right(
          await sharefPref.setString('cart', jsonEncode(convertedList)));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid decrementItem({required int plId}) async {
    try {
      final sharefPref = await SharedPreferences.getInstance();

      final cartItemsStrings = sharefPref.getString("cart");

      final List<dynamic> cartList = jsonDecode(cartItemsStrings!);

      final List<Cart> convertedList =
          cartList.map((e) => Cart.fromJson(e)).toList();

      final itemToBeIncemented =
          convertedList.indexWhere((item) => item.pl_id == plId);

      Cart existingItem = convertedList[itemToBeIncemented];

      if (existingItem.quantity > 1) {
        convertedList[itemToBeIncemented] =
            existingItem.copyWith(quantity: existingItem.quantity - 1);
      }

      return right(
          await sharefPref.setString('cart', jsonEncode(convertedList)));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}