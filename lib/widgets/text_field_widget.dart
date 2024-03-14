import 'package:flutter/material.dart';
import '../constants.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.height = 50,
  });

  final TextEditingController controller;
  final String hintText;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      height: height,
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 0.2, color: kYellow),
          boxShadow: [
            BoxShadow(
                color: kBlack.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(2, 3)
            )
          ]
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: kGreen,
        style: kGreenStyle,
        maxLines: 2,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)
          ),
          hintText: hintText,
          isCollapsed: true,
          hintStyle: kGreenStyle.copyWith(
              color: kGreen.withOpacity(0.6),
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}