import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unico/domain/models/product_model.dart';
import 'package:unico/presentation/widgets/product.dart';
import 'package:unico/utils/instances.dart';
import 'package:unico/utils/styles.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key, required this.productList});

  final List<ProductModel> productList;
  final double delivery = 100;
  final double tax = 10;

  @override
  Widget build(BuildContext context) {
    double grandTotal = delivery + tax + cartController.cartValue.value;
    return Scaffold(
      appBar: appBar.build(context, title: "Checkout", showCart: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Text(
                "Order Details",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: cartController.cartPopulatedItems.length,
                itemBuilder: (context, index) {
                  return Product(
                    product: cartController.cartPopulatedItems[index],
                    isCheckout: true,
                  );
                }),
            const SizedBox(
              height: 250,
            )
          ],
        ),
      ),
      bottomSheet: SizedBox(
        height: 220,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "ORDER SUMMARY",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sub Total:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₹${cartController.cartValue.toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Shipping:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₹${delivery.toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Tax:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₹${tax.toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                height: 1.5,
                color: Colors.black,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₹${grandTotal.toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 1.5,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                // width: 120,
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(30.0),
                    right: Radius.circular(30.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Place Order',
                    style: Styles.title,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
