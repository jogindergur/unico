import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unico/presentation/pages/cart.dart';
import 'package:unico/presentation/pages/login.dart';
import 'package:unico/utils/instances.dart';
import 'package:unico/utils/styles.dart';

class CustomAppBar extends AppBar {
  static CustomAppBar instance = Get.find();
  CustomAppBar({Key? key}) : super(key: key);

  AppBar build(BuildContext context,
      {required String title,
      bool showBackButton = true,
      bool showCart = true}) {
    return AppBar(
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios),
            )
          : null,
      title: Text(
        title,
        style: Styles.heading,
      ),
      actions: [
        showCart
            ? InkWell(
                onTap: () {
                  Get.to(() => const Cart());
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: Badge(
                      backgroundColor: Colors.green.shade300,
                      label: Obx(
                        () => Text(
                          "${cartController.cartItems.keys.length}",
                          style: Styles.title,
                        ),
                      ),
                      child: const Icon(Icons.shopping_cart)),
                ),
              )
            : Container(),
        InkWell(
          onTap: () async {
            await authController.logout();
            Get.offAll(const LoginPage());
          },
          child: Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: const Icon(Icons.logout_outlined),
          ),
        ),
      ],
    );
  }
}
