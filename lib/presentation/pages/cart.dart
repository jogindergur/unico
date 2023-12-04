import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unico/presentation/pages/checkout_page.dart';
import 'package:unico/presentation/pages/detail_page.dart';
import 'package:unico/presentation/widgets/empty_cart.dart';
import 'package:unico/presentation/widgets/product.dart';
import 'package:unico/utils/instances.dart';
import 'package:unico/utils/styles.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    // cartController.populateCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.build(
        context,
        title: "Cart",
        showCart: false,
      ),
      body: cartController.cartItems.keys.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(
                          () => Text(
                            'Total Items: ${cartController.cartPopulatedItems.length}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: cartController.populateCart(),
                      builder: (context, snapshot) {
                        return Obx(
                          () => cartController.cartItems.keys.isNotEmpty
                              ? ListView.builder(
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      cartController.cartPopulatedItems.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () => Get.to(
                                        () => DetailPage(
                                          product: cartController
                                              .cartPopulatedItems[index],
                                        ),
                                      ),
                                      child: Product(
                                        product: cartController
                                            .cartPopulatedItems[index],
                                        isCart: true,
                                      ),
                                    );
                                  })
                              : const EmptyCart(),
                        );
                      }),
                  const SizedBox(
                    height: 70,
                  )
                ],
              ),
            )
          : const EmptyCart(),
      bottomSheet: cartController.cartItems.keys.isNotEmpty
          ? SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        "Amount: ₹${cartController.cartValue.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => CheckOutPage(
                            productList: cartController.cartPopulatedItems));
                      },
                      child: Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.green.shade300,
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(30.0),
                            right: Radius.circular(30.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Checkout',
                            style: Styles.title,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
