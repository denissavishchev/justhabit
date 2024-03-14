import 'package:flutter/material.dart';
import 'package:justhabit/providers/good_provider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

enum Days{
  one,
  two,
}

class DaysButtonWidget extends StatelessWidget {
  const DaysButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GoodProvider>(
        builder: (context, data, _){
          return SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Days', style: kGreenStyle,),
                Button(text: '30',
                  onPress: () => data.selectDay(30),
                  isPressed: data.selectedDays == Days.one ? true : false,),
                Button(text: '60',
                  onPress: () => data.selectDay(60),
                  isPressed: data.selectedDays == Days.two ? true : false,),
              ],
            ),
          );
        });
  }
}

class Button extends StatelessWidget {
  const Button({
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
        width: 35,
        height: 35,
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
            border: isPressed ? Border.all(width: 1, color: kGreen) : null,
            boxShadow: [
              BoxShadow(
                  color: isPressed ? kGreen.withOpacity(0.1) : kBlack.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(1, 2)
              )
            ]
        ),
        child: Center(child: Text(text, 
          style: isPressed
              ? kGreenStyle
              : kGreenStyle.copyWith(color: kGreen.withOpacity(0.5)),)),
      ),
    );
  }
}