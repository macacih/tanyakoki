import 'package:flutter/material.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 324,
    height: 356,
  );
}

Image logosplash(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 600,
    height: 600,
  );
}

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      controller: textEditingController,
      cursorColor: const Color.fromARGB(255, 0, 0, 0),
      style: TextStyle(
        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.9),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.9),
        ),
        fillColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(1),
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
