import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unico/utils/instances.dart';
import 'package:unico/utils/styles.dart';
import 'package:unico/utils/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              const Center(
                child: Text('Login'),
              ),
              Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: Styles.getFormFieldDecor("Email"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                       return CustomValidator.emailValidation(
                            value: value!, name: "Email");
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: Styles.getFormFieldDecor("Password"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                       return CustomValidator.passwordValidation(
                            value: value!, name: "Password");
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formkey.currentState?.validate() ?? false) {
                          if (!authController.isLoading.value) {
                          await authController.signInWithMail();
                        }
                        }
                        
                      },
                      child: Obx(() => Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: authController.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset("assets/unico-logo.png"),
                                        const SizedBox(
                                          width: 30.0,
                                        ),
                                        const Text(
                                          "Login with UC",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
