import 'package:flutter/material.dart';
import 'package:justhabit/providers/good_provider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'button_widget.dart';

enum Done{
  one,
  two,
  three,
}

class ActionsButtonWidget extends StatelessWidget {
  const ActionsButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GoodProvider>(
        builder: (context, data, _){
          return SizedBox(
            width: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Actions', style: kGreenStyle,),
                ButtonWidget(text: '1',
                  onPress: () => data.selectAction(1),
                  isPressed: data.selectedActions == Done.one ? true : false,),
                ButtonWidget(text: '2',
                  onPress: () => data.selectAction(2),
                  isPressed: data.selectedActions == Done.two ? true : false,),
                ButtonWidget(text: '3',
                  onPress: () => data.selectAction(3),
                  isPressed: data.selectedActions == Done.three ? true : false,),
              ],
            ),
          );
        });
  }
}

