import 'package:get/get.dart';
import 'package:unico/data/product_data_store.dart';
import 'package:unico/domain/models/product_model.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();

  var productList = <ProductModel>[].obs;

  Future<List<ProductModel>> getAllProducts() async {
    productList.clear();
    for (var data in ProductDataStore.rawProductData) {
      productList.add(ProductModel.fromJson(data));
    }
    return productList;
  }

  Future<ProductModel?> getProductById(String productId) async {
    ProductModel? product;

    for (var element in productList) {
      if (element.id == productId) {
        product = element;
        break;
      }
    }

    return product;
  }
}
