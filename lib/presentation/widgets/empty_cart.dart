import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unico/presentation/pages/product_list.dart';
import 'package:unico/utils/styles.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset("assets/cart_is_empty.png"),
          InkWell(
            onTap: () {
              Get.to(() => const ProductList());
            },
            child: Container(
              height: 60,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.green.shade300,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(30.0),
                  right: Radius.circular(30.0),
                ),
              ),
              child: Center(
                child: Text(
                  'Go to Products',
                  style: Styles.title,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
