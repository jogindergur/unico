import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unico/domain/models/product_model.dart';
import 'package:unico/utils/instances.dart';
import 'package:unico/utils/shared_preference.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();

  var cartItems = {}.obs;
  var cartPopulatedItems = <ProductModel>[].obs;
  var cartValue = 0.0.obs;
  bool isSnackBarShowing = false;

  @override
  void onInit() async {
    String? previousCart = prefs?.getString("cartItems");
    if (previousCart != null) {
      cartItems.value = jsonDecode(previousCart);
    }
    super.onInit();
  }

  //To add product to cart or increase quantity of product
  addQuantity(String productId) {
    if (productId.isNotEmpty) {
      if (cartItems.containsKey(productId)) {
        cartItems[productId] += 1;
      } else {
        cartItems[productId] = 1;
        showMessage('Product added to cart');
      }
    } else {
      showMessage('Something went wrong');
    }
    saveCart();
  }

  //To remove product to cart or decrease quantity of product
  removeQuantity(String productId) {
    if (productId.isNotEmpty) {
      if (cartItems.containsKey(productId)) {
        //if product quantity is one then remove product
        if (cartItems[productId] > 1) {
          cartItems[productId] -= 1;
        } else {
          cartItems.remove(productId);
          showMessage('Product removed from cart');
        }
      }
    } else {
      showMessage('Something went wrong');
    }
    saveCart();
  }

  //To directly remove product from cart
  removeProduct(String productId) {
    if (productId.isNotEmpty) {
      cartItems.remove(productId);
      showMessage('Product removed from cart');
    } else {
      showMessage('Something went wrong');
    }
    saveCart();
  }

  //Populate cart item
  Future<List<ProductModel>> populateCart() async {
    cartPopulatedItems.clear();
    try {
      cartValue.value = 0.0;
      for (var key in cartItems.keys) {
        ProductModel? product = await productController.getProductById(key);

        if (product != null) {
          product.quantity = cartItems[key];
          product.totalAmount = (product.quantity ?? 0) * (product.price ?? 0);
          cartValue.value += product.totalAmount?.toDouble() ?? 0.0;
          cartPopulatedItems.add(product);
        }
      }
      return cartPopulatedItems;
    } catch (e) {
      return cartPopulatedItems;
    }
  }

  showMessage(String message) {
    if (!isSnackBarShowing) {
      isSnackBarShowing = true;
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(message),
            ),
          )
          .closed
          .then((SnackBarClosedReason reason) {
        isSnackBarShowing = false;
      });
    }
  }

  saveCart() async {
    await prefs?.setString("cartItems", jsonEncode(cartItems));
  }
}
