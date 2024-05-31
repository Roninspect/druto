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

final isInCartProvider = FutureProvider.family<Cart?, int>((ref, plId) async {
  return ref.watch(localCartProvider).isInCart(
        plId: plId,
      );
});
final isPackageInCartProvider =
    FutureProvider.family<Cart?, int>((ref, pckgl_id) async {
  return ref.watch(localCartProvider).isPackageInCart(
        pckgl_id: pckgl_id,
      );
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

        convertedList[existingItemIndex] =
            existingItem.copyWith(quantity: existingItem.quantity + 1);
      } else {
        convertedList.add(localIds);
      }

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

  FutureVoid incrementItem({int? plId, int? pckglId}) async {
    try {
      final sharefPref = await SharedPreferences.getInstance();

      final cartItemsStrings = sharefPref.getString("cart");

      final List<dynamic> cartList = jsonDecode(cartItemsStrings!);

      final List<Cart> convertedList =
          cartList.map((e) => Cart.fromJson(e)).toList();

      final itemToBeIncemented = plId != null
          ? convertedList.indexWhere((item) => item.pl_id == plId)
          : convertedList.indexWhere((item) => item.pckgl_id == pckglId);

      Cart existingItem = convertedList[itemToBeIncemented];

      convertedList[itemToBeIncemented] =
          existingItem.copyWith(quantity: existingItem.quantity + 1);

      return right(
          await sharefPref.setString('cart', jsonEncode(convertedList)));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid decrementItem({int? plId, int? pckgId}) async {
    try {
      final sharefPref = await SharedPreferences.getInstance();

      final cartItemsStrings = sharefPref.getString("cart");

      final List<dynamic> cartList = jsonDecode(cartItemsStrings!);

      final List<Cart> convertedList =
          cartList.map((e) => Cart.fromJson(e)).toList();

      final itemToBeIncemented = plId != null
          ? convertedList.indexWhere((item) => item.pl_id == plId)
          : convertedList.indexWhere((item) => item.pckgl_id == pckgId);

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

  FutureVoid removeItemFromCart({int? plId, int? pckgId}) async {
    try {
      final sharefPref = await SharedPreferences.getInstance();

      final cartItemsStrings = sharefPref.getString("cart");

      final List<dynamic> cartList = jsonDecode(cartItemsStrings!);

      final List<Cart> convertedList =
          cartList.map((e) => Cart.fromJson(e)).toList();

      final indexToRemove = plId != null
          ? convertedList.indexWhere((item) => item.pl_id == plId)
          : convertedList.indexWhere((item) => item.pckgl_id == pckgId);

      if (indexToRemove != -1) {
        convertedList.removeAt(indexToRemove);
      }

      return right(
          await sharefPref.setString('cart', jsonEncode(convertedList)));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Cart?> isInCart({int? plId}) async {
    try {
      final sharefPref = await SharedPreferences.getInstance();

      final cartItemsStrings = sharefPref.getString("cart");

      final List<dynamic> cartList = jsonDecode(cartItemsStrings!);

      final List<Cart> convertedList =
          cartList.map((e) => Cart.fromJson(e)).toList();

      final itemIndex = convertedList.indexWhere((item) => item.pl_id == plId);

      if (itemIndex == -1) {
        return null;
      }

      final Cart existingItem = convertedList[itemIndex];

      return existingItem;
    } catch (e) {
      return null;
    }
  }

  Future<Cart?> isPackageInCart({int? pckgl_id}) async {
    try {
      final sharefPref = await SharedPreferences.getInstance();

      final cartItemsStrings = sharefPref.getString("cart");

      final List<dynamic> cartList = jsonDecode(cartItemsStrings!);

      final List<Cart> convertedList =
          cartList.map((e) => Cart.fromJson(e)).toList();

      final itemIndex = convertedList.indexWhere((item) {
        return item.pckgl_id == pckgl_id;
      });

      if (itemIndex == -1) {
        return null;
      }

      final Cart existingItem = convertedList[itemIndex];

      return existingItem;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
