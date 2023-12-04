import 'package:flutter/material.dart';

class Styles {
  static TextStyle heading = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  static TextStyle title = const TextStyle(
    color: Colors.black54,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subTitle = const TextStyle(
    color: Colors.black54,
  );

  static InputDecoration getFormFieldDecor(String hint) {
    return InputDecoration(
      hintText: hint,
      // hoverColor: Colors.white,
      fillColor: Colors.white,
      filled: true,
      // focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(50.0),
      //     borderSide: BorderSide.none),
      // enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(50.0),
      //     borderSide: BorderSide.none),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.0),
        borderSide: const BorderSide(color: Colors.black, width: 3.0),
      ),
    );
  }
}
