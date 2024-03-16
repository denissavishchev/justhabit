import 'package:flutter/material.dart';
import '../constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPress,
    required this.isPressed,
  });

  final String text;
  final Function() onPress;
  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
            color: kWhite,
            gradient: isPressed ? LinearGradient(
                colors: [
                  kGreen.withOpacity(0.2),
                  kGrey.withOpacity(0.2)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 0.7]
            ) : null,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: isPressed 
                ? Border.all(width: 1, color: kGreen) 
                : Border.all(width: 1, color: kGreen.withOpacity(0.5)),
        ),
        child: Center(child: Text(text,
          style: isPressed
              ? kGreenStyleSmall
              : kGreenStyleSmall.copyWith(color: kGreen.withOpacity(0.5)),)),
      ),
    );
  }
}