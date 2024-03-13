import 'package:flutter/material.dart';

class MeuTextField extends StatelessWidget {

  final String hintTextInput;
  final TextStyle style;
  final TextEditingController? controller;
  final int? maxLines;
  final TextInputType tipoDoCampo;
  final bool obscureText;
  final Widget? icone;

  const MeuTextField({
    Key? key, required this.hintTextInput, required this.style,
    this.controller, this.maxLines, this.tipoDoCampo = TextInputType.text,
    this.obscureText = false, this.icone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: hintTextInput,
          hintStyle: const TextStyle(color: Colors.black54),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.transparent
          ),),
          fillColor: Color(0xFFABABAB),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon: icone,
      ),
      style: style,
      controller: controller,
      maxLines: maxLines,
      keyboardType: tipoDoCampo,
      obscureText: obscureText,
      validator: (value){
        if (value == null || value.isEmpty){
          return 'Campo Obrigatório!';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
    );
  }
}
