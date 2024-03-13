import 'package:flutter/material.dart';

class BadPage extends StatelessWidget {
  const BadPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var date = DateTime.now();
    return Center(
      child: SizedBox(
        width: size. width,
        height:  size.height * 0.5,
        child: DateRangePickerDialog(
            firstDate: DateTime.now(),
            lastDate: DateTime(date.year, date.month, date.day + 5),

        ),
        )
    );
  }
}
