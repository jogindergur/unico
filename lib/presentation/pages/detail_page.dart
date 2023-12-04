import 'package:flutter/material.dart';
import 'package:unico/domain/models/product_model.dart';
import 'package:unico/presentation/widgets/product.dart';
import 'package:unico/utils/instances.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.product});
  final ProductModel product;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar.build(context, title: "Product Detail"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Card(
            child: Column(
              children: [
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          widget.product.image ?? "assets/unico-logo.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(14.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Product(
                  isDetail: true,
                  product: widget.product,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.only(left: 26.0, right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.product.description ?? "NA",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
