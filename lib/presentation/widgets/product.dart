import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unico/domain/models/product_model.dart';
import 'package:unico/utils/instances.dart';
import 'package:unico/utils/styles.dart';

class Product extends StatefulWidget {
  const Product({
    super.key,
    this.isDetail = false,
    this.isCart = false,
    this.isCheckout = false,
    required this.product,
  });

  final bool isDetail;
  final bool isCart;
  final bool isCheckout;
  final ProductModel product;
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    bool isInCart = false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(8.0),
        // margin: const EdgeInsets.only(top: 6.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          children: [
            Visibility(
              visible: !widget.isDetail,
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage:
                    AssetImage(widget.product.image ?? "assets/unico-logo.jpg"),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(
                    top: 12.0, left: widget.isDetail ? 10.0 : 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.name ?? 'Product',
                          style: Styles.title,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            widget.isCart
                                ? '₹${widget.product.totalAmount?.toStringAsFixed(2) ?? 0.0}'
                                : '₹${widget.product.price?.toStringAsFixed(2) ?? 0.0}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.category ?? 'Product Category',
                          style: Styles.subTitle,
                        ),
                        widget.isCheckout
                            ? Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Row(
                                  children: [
                                    Text(
                                        'X${widget.product.quantity} = ₹${widget.product.totalAmount?.toStringAsFixed(2) ?? 0.0}')
                                  ],
                                ),
                              )
                            : Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      isInCart = true;
                                    },
                                    child: Obx(() {
                                      isInCart = cartController.cartItems
                                          .containsKey(widget.product.id);
                                      return isInCart
                                          ? Container(
                                              height: 30,
                                              width: 90,
                                              margin: isInCart
                                                  ? const EdgeInsets.only(
                                                      right: 4.0)
                                                  : null,
                                              decoration: BoxDecoration(
                                                // color: Colors.green.shade300,
                                                border: Border.all(
                                                  color: Colors.green.shade300,
                                                ),
                                                borderRadius: const BorderRadius
                                                    .horizontal(
                                                  left: Radius.circular(20.0),
                                                  right: Radius.circular(20.0),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      cartController
                                                          .removeQuantity(widget
                                                                  .product.id ??
                                                              "");
                                                      if (widget.isCart) {
                                                        cartController
                                                            .populateCart();
                                                      }
                                                    },
                                                    child: Container(
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .green.shade300,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .horizontal(
                                                          left: Radius.circular(
                                                              20.0),
                                                          // right:
                                                          //     Radius.circular(20.0),
                                                        ),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          "-",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 28,
                                                    child: Center(
                                                      child: Text(cartController
                                                              .cartItems[widget
                                                                      .product
                                                                      .id ??
                                                                  ""]
                                                              ?.toString() ??
                                                          '0'),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      cartController
                                                          .addQuantity(widget
                                                                  .product.id ??
                                                              "");
                                                      if (widget.isCart) {
                                                        cartController
                                                            .populateCart();
                                                      }
                                                    },
                                                    child: Container(
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .green.shade300,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .horizontal(
                                                          // left:
                                                          //     Radius.circular(20.0),
                                                          right:
                                                              Radius.circular(
                                                                  20.0),
                                                        ),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          "+",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                cartController.addQuantity(
                                                    widget.product.id ?? "");
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  color: Colors.green.shade300,
                                                  borderRadius:
                                                      const BorderRadius
                                                          .horizontal(
                                                    left: Radius.circular(20.0),
                                                    right:
                                                        Radius.circular(20.0),
                                                  ),
                                                ),
                                                child: const Icon(
                                                    Icons.add_shopping_cart,
                                                    size: 16.0),
                                              ),
                                            );
                                    }),
                                  ),
                                  SizedBox(
                                    width: widget.isDetail ? 8.0 : null,
                                  ),
                                  //delete procedure
                                  Visibility(
                                    visible: widget.isCart,
                                    child: InkWell(
                                      onTap: () {
                                        cartController.removeProduct(
                                            widget.product.id ?? "");
                                        if (widget.isCart) {
                                          cartController.populateCart();
                                        }
                                      },
                                      child: const Icon(
                                        Icons.delete_rounded,
                                        size: 24.0,
                                        color: Color.fromARGB(255, 184, 53, 20),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      // ),
    );
  }
}
