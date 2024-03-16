import 'package:flutter/material.dart';
import 'package:justhabit/providers/good_provider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'button_widget.dart';

enum Days{
  fifteen,
  thirty,
  fortyFive,
  sixty,
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
            width: 280,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Days', style: kGreenStyle,),
                ButtonWidget(text: '15',
                  onPress: () => data.selectDay(15),
                  isPressed: data.selectedDays == Days.fifteen ? true : false,),
                ButtonWidget(text: '30',
                  onPress: () => data.selectDay(30),
                  isPressed: data.selectedDays == Days.thirty ? true : false,),
                ButtonWidget(text: '45',
                  onPress: () => data.selectDay(45),
                  isPressed: data.selectedDays == Days.fortyFive ? true : false,),
                ButtonWidget(text: '60',
                  onPress: () => data.selectDay(60),
                  isPressed: data.selectedDays == Days.sixty ? true : false,),
              ],
            ),
          );
        });
  }
}
