import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unico/core/controllers/auth_controller.dart';
import 'package:unico/core/controllers/cart_controller.dart';
import 'package:unico/core/controllers/product_controller.dart';
import 'package:unico/firebase_options.dart';
import 'package:unico/presentation/pages/login.dart';
import 'package:unico/presentation/pages/product_list.dart';
import 'package:unico/presentation/widgets/custom_app_bar.dart';
import 'package:unico/utils/shared_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getSharedPref();
  await Firebase.initializeApp( 
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  Get.put(ProductController());
  Get.put(CartController());
  Get.put(CustomAppBar());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    String? userId = prefs?.getString("UID") ?? "";
    // print("userId: $userId");
    // if (userId != null) {
    //   Future.delayed(Duration.zero).then((value) {
    //     Get.to(() => );
    //   });
    // }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: userId.isNotEmpty? const ProductList() : const LoginPage(),
    );
  }
}
