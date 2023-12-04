import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unico/presentation/pages/detail_page.dart';
import 'package:unico/presentation/widgets/product.dart';
import 'package:unico/utils/instances.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar.build(
        context,
        title: "Products",
        showBackButton: false,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 1.5,
            color: Colors.black,
            margin: const EdgeInsets.only(top: 6.0),
          ),
          FutureBuilder(
              future: productController.getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: productController.productList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Get.to(
                              () => DetailPage(
                                product: productController.productList[index],
                              ),
                            ),
                            child: Product(
                              product: productController.productList[index],
                            ),
                          );
                        }),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }
}
